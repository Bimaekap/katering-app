// ==========================================================
// firebase_service.dart
// Semua operasi Firebase (Auth + Firestore) dipusatkan di sini.
// Import file ini di setiap halaman yang butuh Firebase.
// ==========================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // ==============================================================
  // AUTH HELPERS
  // ==============================================================
  static User? get currentUser => _auth.currentUser;
  static String? get currentUserId => _auth.currentUser?.uid;

  // ==============================================================
  // REGISTER PELANGGAN BARU
  // Dipanggil dari: register_page.dart
  // Membuat akun di Firebase Auth + dokumen di koleksi "users"
  // ==============================================================
  static Future<Map<String, dynamic>> register({
    required String nama,
    required String email,
    required String noHp,
    required String password,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _db.collection('users').doc(cred.user!.uid).set({
        'nama': nama,
        'email': email,
        'noHp': noHp,
        'role': 'pelanggan',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return {'success': true};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'message': e.message ?? 'Terjadi kesalahan'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==============================================================
  // LOGIN PELANGGAN
  // Dipanggil dari: login_page.dart
  // Memverifikasi role = 'pelanggan'
  // ==============================================================
  static Future<Map<String, dynamic>> loginPelanggan({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final doc = await _db.collection('users').doc(cred.user!.uid).get();
      if (!doc.exists) {
        await _auth.signOut();
        return {'success': false, 'message': 'Data akun tidak ditemukan'};
      }
      final data = doc.data() as Map<String, dynamic>;
      if (data['role'] != 'pelanggan') {
        await _auth.signOut();
        return {'success': false, 'message': 'Gunakan halaman Login Admin'};
      }
      return {'success': true};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'message': e.message ?? 'Terjadi kesalahan'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // ==============================================================
  // LOGIN ADMIN
  // Dipanggil dari: loginadmin_page.dart
  // Memverifikasi role = 'admin'
  // PENTING: Buat akun admin manual di Firestore dengan role:'admin'
  // ==============================================================
  static Future<Map<String, dynamic>> loginAdmin({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final doc = await _db.collection('users').doc(cred.user!.uid).get();
      if (!doc.exists) {
        await _auth.signOut();
        return {'success': false, 'message': 'Akun admin tidak ditemukan'};
      }
      final data = doc.data() as Map<String, dynamic>;
      if (data['role'] != 'admin') {
        await _auth.signOut();
        return {'success': false, 'message': 'Anda bukan admin'};
      }
      return {'success': true};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'message': e.message ?? 'Terjadi kesalahan'};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // LOGOUT
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // ==============================================================
  // DATA USER
  // Dipanggil dari: profil_page.dart
  // ==============================================================
  static Future<Map<String, dynamic>?> getUserData() async {
    if (currentUserId == null) return null;
    final doc = await _db.collection('users').doc(currentUserId).get();
    if (!doc.exists) return null;
    return doc.data() as Map<String, dynamic>;
  }

  static Stream<DocumentSnapshot> streamUserData() {
    return _db.collection('users').doc(currentUserId).snapshots();
  }

  // ==============================================================
  // KOLEKSI: menus
  // Fields: nama, deskripsi, harga (int), kategori, foto_url,
  //         status ('aktif'/'nonaktif'), stok (int), createdAt
  // Dipanggil dari: home_page.dart, datamenu.dart, tambahmenu.dart
  // ==============================================================
  static Stream<QuerySnapshot> streamMenusAktif() {
    return _db
        .collection('menus')
        .where('status', isEqualTo: 'aktif')
        .snapshots();
  }

  static Stream<QuerySnapshot> streamSemuaMenus() {
    return _db.collection('menus').snapshots();
  }

  static Future<void> tambahMenu({
    required String nama,
    required String deskripsi,
    required int harga,
    required String kategori,
    String fotoUrl = '',
    String status = 'aktif',
    int stok = 0,
  }) async {
    await _db.collection('menus').add({
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga,
      'kategori': kategori,
      'foto_url': fotoUrl,
      'status': status,
      'stok': stok,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateMenu(
      String menuId, Map<String, dynamic> data) async {
    await _db.collection('menus').doc(menuId).update(data);
  }

  static Future<void> hapusMenu(String menuId) async {
    await _db.collection('menus').doc(menuId).delete();
  }

  // ==============================================================
  // KOLEKSI: pesanan
  // Fields: userId, namaCustomer, nomorHp, alamat, catatan,
  //         tanggalPemesanan (String), tanggalAcara (String),
  //         items (Array<{menuId,namaMenu,harga,qty}>),
  //         totalHarga (int), totalPorsi (int),
  //         statusPesanan (String), createdAt (Timestamp)
  //
  // Status alur: menunggu_konfirmasi → diproses → dikirim → selesai
  //              pengajuan_pembatalan → dibatalkan
  //              menunggu_verifikasi_pembayaran
  //
  // Dipanggil dari: keranjang_page.dart, datapesanan.dart,
  //                 riwayat_page.dart
  // ==============================================================
  static Future<String?> simpanPesanan({
    required String namaCustomer,
    required String nomorHp,
    required String alamat,
    required String catatan,
    required String tanggalPemesanan,
    required String tanggalAcara,
    required List<Map<String, dynamic>> items,
    required int totalHarga,
    required int totalPorsi,
  }) async {
    try {
      final ref = await _db.collection('pesanan').add({
        'userId': currentUserId ?? '',
        'namaCustomer': namaCustomer,
        'nomorHp': nomorHp,
        'alamat': alamat,
        'catatan': catatan,
        'tanggalPemesanan': tanggalPemesanan,
        'tanggalAcara': tanggalAcara,
        'items': items,
        'totalHarga': totalHarga,
        'totalPorsi': totalPorsi,
        'statusPesanan': 'menunggu_konfirmasi',
        'createdAt': FieldValue.serverTimestamp(),
      });
      // ======= NOTIFIKASI: Pesanan berhasil dibuat =======
      final namaMenus = items
          .map((i) => (i['namaMenu'] ?? i['title'] ?? '').toString())
          .where((s) => s.isNotEmpty)
          .join(', ');
      final totalFmt = NumberFormat.decimalPattern('id').format(totalHarga);
      await simpanNotifikasi(
        targetUserId: currentUserId ?? '',
        title: 'Pesanan Berhasil Dibuat',
        message:
            'Pesanan Anda ($namaMenus) — $totalPorsi porsi — total Rp. $totalFmt '
            'telah diterima. Menunggu konfirmasi admin.',
        type: 'pesanan',
      );
      return ref.id;
    } catch (_) {
      return null;
    }
  }

  static Stream<QuerySnapshot> streamSemuaPesanan() {
    return _db
        .collection('pesanan')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // UPLOAD BUKTI PEMBAYARAN KE FIREBASE STORAGE DAN UPDATE PEMBAYARAN + PESANAN
  static Future<String?> uploadBuktiPembayaran(
      String pesananId, String filePath) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('bukti_pembayaran')
          .child('$pesananId-${DateTime.now().millisecondsSinceEpoch}.jpg');
      // Read file bytes (works on mobile/desktop). On web, prefer
      // uploadBuktiPembayaranFromBytes because File is not available.
      final file = File(filePath);
      final bytes = await file.readAsBytes();
      await ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

  // Upload dari byte array (bekerja di web & mobile)
  static Future<String?> uploadBuktiPembayaranFromBytes(
      String pesananId, Uint8List bytes,
      {String contentType = 'image/jpeg'}) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('bukti_pembayaran')
          .child('$pesananId-${DateTime.now().millisecondsSinceEpoch}.jpg');
      // putData works on web and mobile when provided bytes
      await ref.putData(bytes, SettableMetadata(contentType: contentType));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

  static Stream<QuerySnapshot> streamPesananUser() {
    return _db
        .collection('pesanan')
        .where('userId', isEqualTo: currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static Future<void> updateStatusPesanan(
      String pesananId, String status) async {
    await _db
        .collection('pesanan')
        .doc(pesananId)
        .update({'statusPesanan': status});
  }

  // Update status DAN kirim notifikasi ke user (dipakai oleh admin)
  static Future<void> updateStatusPesananDanNotif(
    String pesananId,
    String status,
    String userId,
  ) async {
    await updateStatusPesanan(pesananId, status);
    if (userId.isEmpty) return;
    const Map<String, String> _statusMsg = {
      'diproses': 'Pesanan Anda sedang diproses dan disiapkan oleh dapur.',
      'dikirim': 'Pesanan Anda sedang dalam pengiriman ke alamat Anda.',
      'selesai': 'Pesanan Anda telah selesai. Terima kasih telah memesan!',
      'dibatalkan': 'Pesanan Anda telah dibatalkan.',
      'menunggu_verifikasi_pembayaran':
          'Pembayaran Anda diterima dan sedang diverifikasi admin.',
    };
    final msg =
        _statusMsg[status] ?? 'Status pesanan Anda diperbarui: $status.';
    await simpanNotifikasi(
      targetUserId: userId,
      title: 'Update Pesanan',
      message: msg,
      type: 'pesanan',
    );
  }

  // ==============================================================
  // KOLEKSI: pembayaran
  // Fields: pesananId, userId, namaCustomer, nomorHp,
  //         tanggalBayar (Timestamp), jenisPembayaran ('dp'/'lunas'),
  //         nominal (int), metodePembayaran ('transfer'/'ewallet'),
  //         bankEwallet (String), buktiBayarUrl (String),
  //         status ('menunggu_verifikasi'/'terverifikasi'/'ditolak'),
  //         createdAt (Timestamp)
  //
  // Dipanggil dari: transfer_page.dart, ewallet_page.dart,
  //                 datapembayaran.dart
  // ==============================================================
  static Future<void> simpanPembayaran({
    required String pesananId,
    required String namaCustomer,
    required String nomorHp,
    required String jenisPembayaran,
    required int nominal,
    required String metodePembayaran,
    required String bankEwallet,
    String buktiBayarUrl = '',
  }) async {
    await _db.collection('pembayaran').add({
      'pesananId': pesananId,
      'userId': currentUserId ?? '',
      'namaCustomer': namaCustomer,
      'nomorHp': nomorHp,
      'tanggalBayar': FieldValue.serverTimestamp(),
      'jenisPembayaran': jenisPembayaran,
      'nominal': nominal,
      'metodePembayaran': metodePembayaran,
      'bankEwallet': bankEwallet,
      'buktiBayarUrl': buktiBayarUrl,
      'status': 'menunggu_verifikasi',
      'createdAt': FieldValue.serverTimestamp(),
    });
    await updateStatusPesanan(pesananId, 'menunggu_verifikasi_pembayaran');
    // ======= NOTIFIKASI: Pembayaran diterima =======
    final nominalFmt = NumberFormat.decimalPattern('id').format(nominal);
    final metodeLabel =
        metodePembayaran == 'transfer' ? 'Transfer Bank' : 'E-Wallet';
    final bankLabel = (bankEwallet.isNotEmpty) ? ' ($bankEwallet)' : '';
    await simpanNotifikasi(
        targetUserId: currentUserId ?? '',
        title: 'Pembayaran Diterima',
        message:
            'Pembayaran $jenisPembayaran Rp. $nominalFmt via $metodeLabel$bankLabel '
            'sedang menunggu verifikasi admin.',
        type: 'pembayaran');
  }

  static Stream<QuerySnapshot> streamSemuaPembayaran() {
    return _db
        .collection('pembayaran')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static Future<void> updateStatusPembayaran(
      String pembayaranId, String status) async {
    await _db
        .collection('pembayaran')
        .doc(pembayaranId)
        .update({'status': status});
  }

  // ==============================================================
  // KOLEKSI: users (sebagai data pelanggan di sisi admin)
  // Fields: nama, email, noHp, role, createdAt
  //
  // Dipanggil dari: datapelanggan.dart
  // ==============================================================
  static Stream<QuerySnapshot> streamPelanggan() {
    return _db
        .collection('users')
        .where('role', isEqualTo: 'pelanggan')
        .snapshots();
  }

  // ==============================================================
  // KOLEKSI: pembatalan
  // Fields: pesananId, userId, namaCustomer, nomorHp,
  //         alasanPembatalan, tanggalPembatalan (Timestamp),
  //         status ('pending'/'disetujui'/'ditolak'),
  //         createdAt (Timestamp)
  //
  // Dipanggil dari: datapembatalan.dart,
  //                 (opsional dari riwayat/detail pesanan user)
  // ==============================================================
  static Future<void> ajukanPembatalan({
    required String pesananId,
    required String namaCustomer,
    required String nomorHp,
    required String alasan,
  }) async {
    await _db.collection('pembatalan').add({
      'pesananId': pesananId,
      'userId': currentUserId ?? '',
      'namaCustomer': namaCustomer,
      'nomorHp': nomorHp,
      'alasanPembatalan': alasan,
      'tanggalPembatalan': FieldValue.serverTimestamp(),
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
    await updateStatusPesanan(pesananId, 'pengajuan_pembatalan');
  }

  static Stream<QuerySnapshot> streamSemuaPembatalan() {
    return _db
        .collection('pembatalan')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static Future<void> updateStatusPembatalan(
      String pembatalanId, String status, String pesananId) async {
    await _db
        .collection('pembatalan')
        .doc(pembatalanId)
        .update({'status': status});
    final statusPesanan = status == 'disetujui' ? 'dibatalkan' : 'aktif';
    await updateStatusPesanan(pesananId, statusPesanan);
  }

  // ==============================================================
  // KOLEKSI: notifikasi
  // Fields: targetUserId, title, message, type, isRead (bool),
  //         createdAt (Timestamp)
  //
  // Dipanggil dari: datapembatalan.dart, datapembayaran.dart
  // ==============================================================
  static Future<void> simpanNotifikasi({
    required String targetUserId,
    required String title,
    required String message,
    required String type,
  }) async {
    await _db.collection('notifikasi').add({
      'targetUserId': targetUserId,
      'title': title,
      'message': message,
      'type': type,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Stream<QuerySnapshot> streamNotifikasiUser() {
    return _db
        .collection('notifikasi')
        .where('targetUserId', isEqualTo: currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
