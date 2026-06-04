// =================================================================
// seed_data_page.dart
// Halaman untuk mengisi Firestore dengan data contoh (testing).
// GUNAKAN SEKALI SAJA. Hapus navigasi ke halaman ini setelahnya.
//
// Cara pakai:
// 1. Tambahkan tombol/navigator ke SeedDataPage() di main.dart sementara
// 2. Klik tombol sesuai urutan:
//    a. "Buat Akun Admin" → buat 1 akun admin
//    b. "Buat Akun Pelanggan" → buat 3 akun pelanggan
//    c. "Isi Data Menu" → isi 6 menu katering
//    d. "Isi Data Pesanan" → isi 4 pesanan contoh
//    e. "Isi Data Pembayaran" → isi 3 pembayaran contoh
//    f. "Isi Data Pembatalan" → isi 2 pembatalan contoh
//    g. "Isi Data Notifikasi" → isi 3 notifikasi contoh
// =================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SeedDataPage extends StatefulWidget {
  const SeedDataPage({super.key});

  @override
  State<SeedDataPage> createState() => _SeedDataPageState();
}

class _SeedDataPageState extends State<SeedDataPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _log = '';
  bool _loading = false;

  void _addLog(String msg) {
    setState(() => _log += '\n✅ $msg');
  }

  void _addError(String msg) {
    setState(() => _log += '\n❌ $msg');
  }

  // ==============================================================
  // HELPER: buat atau login akun, lalu set dokumen Firestore
  // ==============================================================
  Future<String?> _getOrCreateUser(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Akun sudah ada → login saja untuk dapat UID
        final cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return cred.user!.uid;
      }
      rethrow;
    }
  }

  // ==============================================================
  // 1. BUAT AKUN ADMIN
  // Email: admin@katering.com | Password: admin123
  // ==============================================================
  Future<void> _buatAkunAdmin() async {
    setState(() {
      _loading = true;
      _log += '\n--- Membuat Akun Admin ---';
    });
    try {
      final uid = await _getOrCreateUser('admin@katering.com', 'admin123');
      await _db.collection('users').doc(uid).set({
        'nama': 'Admin Ridu Sianturi',
        'email': 'admin@katering.com',
        'noHp': '081200000001',
        'role': 'admin',
        'createdAt': FieldValue.serverTimestamp(),
      });
      _addLog('Admin OK: admin@katering.com / admin123');
    } catch (e) {
      _addError('Admin: $e');
    }
    setState(() => _loading = false);
  }

  // ==============================================================
  // 2. BUAT AKUN PELANGGAN (3 akun)
  // ==============================================================
  Future<void> _buatAkunPelanggan() async {
    setState(() {
      _loading = true;
      _log += '\n--- Membuat Akun Pelanggan ---';
    });

    final pelangganList = [
      {
        'nama': 'Dyren Sihombing',
        'email': 'dyren@gmail.com',
        'noHp': '081234567801'
      },
      {
        'nama': 'Rani Simanjuntak',
        'email': 'rani@gmail.com',
        'noHp': '081234567802'
      },
      {
        'nama': 'Budi Santoso',
        'email': 'budi@gmail.com',
        'noHp': '081234567803'
      },
    ];

    for (final p in pelangganList) {
      try {
        final uid = await _getOrCreateUser(p['email']!, 'pelanggan123');
        await _db.collection('users').doc(uid).set({
          'nama': p['nama'],
          'email': p['email'],
          'noHp': p['noHp'],
          'role': 'pelanggan',
          'createdAt': FieldValue.serverTimestamp(),
        });
        _addLog('Pelanggan OK: ${p['email']} / pelanggan123');
      } catch (e) {
        _addError('Pelanggan ${p['email']}: $e');
      }
    }
    setState(() => _loading = false);
  }

  // ==============================================================
  // 3. ISI DATA MENU (6 menu)
  // ==============================================================
  Future<void> _isiDataMenu() async {
    setState(() {
      _loading = true;
      _log += '\n--- Mengisi Data Menu ---';
    });

    final menus = [
      {
        'nama': 'Nasi Goreng Spesial',
        'deskripsi': 'Nasi goreng dengan telur, ayam, dan sayuran pilihan',
        'harga': 35000,
        'kategori': 'Makanan Utama',
        'foto_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Nasi_goreng.jpg/640px-Nasi_goreng.jpg',
        'status': 'aktif',
        'stok': 50,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'nama': 'Soto Ayam Medan',
        'deskripsi': 'Soto ayam kuah bening khas Medan dengan lontong',
        'harga': 30000,
        'kategori': 'Makanan Utama',
        'foto_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Soto_ayam_lamongan.jpg/640px-Soto_ayam_lamongan.jpg',
        'status': 'aktif',
        'stok': 40,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'nama': 'Ayam Bakar Bumbu Kecap',
        'deskripsi': 'Ayam bakar dengan bumbu kecap manis dan rempah pilihan',
        'harga': 45000,
        'kategori': 'Makanan Utama',
        'foto_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Ayam-bakar-wiki.jpg/640px-Ayam-bakar-wiki.jpg',
        'status': 'aktif',
        'stok': 30,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'nama': 'Rendang Daging Sapi',
        'deskripsi': 'Rendang daging sapi empuk dengan santan dan bumbu khas',
        'harga': 55000,
        'kategori': 'Makanan Utama',
        'foto_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Rendang_-_By_Farizun_Amrod_Saad.jpg/640px-Rendang_-_By_Farizun_Amrod_Saad.jpg',
        'status': 'aktif',
        'stok': 25,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'nama': 'Es Teh Manis',
        'deskripsi': 'Teh manis segar dengan es batu',
        'harga': 8000,
        'kategori': 'Minuman',
        'foto_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Es_teh_manis.jpg/640px-Es_teh_manis.jpg',
        'status': 'aktif',
        'stok': 100,
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'nama': 'Paket Nasi Box Hemat',
        'deskripsi': 'Nasi + 1 lauk + sayur + kerupuk, cocok untuk acara',
        'harga': 25000,
        'kategori': 'Paket',
        'foto_url':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/640px-Good_Food_Display_-_NCI_Visuals_Online.jpg',
        'status': 'aktif',
        'stok': 200,
        'createdAt': FieldValue.serverTimestamp(),
      },
    ];

    for (final menu in menus) {
      try {
        await _db.collection('menus').add(menu);
        _addLog('Menu: ${menu['nama']}');
      } catch (e) {
        _addError('Menu ${menu['nama']}: $e');
      }
    }
    setState(() => _loading = false);
  }

  // ==============================================================
  // 4. ISI DATA PESANAN (4 pesanan)
  // Catatan: userId diisi 'demo-user' karena tidak ada auth aktif
  // ==============================================================
  Future<void> _isiDataPesanan() async {
    setState(() {
      _loading = true;
      _log += '\n--- Mengisi Data Pesanan ---';
    });

    final pesananList = [
      {
        'userId': 'demo-user-1',
        'namaCustomer': 'Dyren Sihombing',
        'nomorHp': '081234567801',
        'alamat': 'Jl. Sudirman No.12, Medan',
        'catatan': 'Tolong tidak terlalu pedas',
        'tanggalPemesanan': Timestamp.fromDate(DateTime(2026, 5, 28)),
        'tanggalAcara': Timestamp.fromDate(DateTime(2026, 6, 5)),
        'items': [
          {'nama': 'Nasi Goreng Spesial', 'harga': 35000, 'jumlah': 50},
          {'nama': 'Es Teh Manis', 'harga': 8000, 'jumlah': 50},
        ],
        'totalHarga': 2150000,
        'totalPorsi': 100,
        'statusPesanan': 'menunggu_konfirmasi',
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'userId': 'demo-user-2',
        'namaCustomer': 'Rani Simanjuntak',
        'nomorHp': '081234567802',
        'alamat': 'Jl. Gatot Subroto No.5, Medan',
        'catatan': 'Untuk acara pernikahan 200 orang',
        'tanggalPemesanan': Timestamp.fromDate(DateTime(2026, 5, 30)),
        'tanggalAcara': Timestamp.fromDate(DateTime(2026, 6, 10)),
        'items': [
          {'nama': 'Rendang Daging Sapi', 'harga': 55000, 'jumlah': 100},
          {'nama': 'Paket Nasi Box Hemat', 'harga': 25000, 'jumlah': 100},
        ],
        'totalHarga': 8000000,
        'totalPorsi': 200,
        'statusPesanan': 'dikonfirmasi',
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'userId': 'demo-user-3',
        'namaCustomer': 'Budi Santoso',
        'nomorHp': '081234567803',
        'alamat': 'Jl. Diponegoro No.88, Medan',
        'catatan': 'Minta tambah sambal',
        'tanggalPemesanan': Timestamp.fromDate(DateTime(2026, 6, 1)),
        'tanggalAcara': Timestamp.fromDate(DateTime(2026, 6, 15)),
        'items': [
          {'nama': 'Ayam Bakar Bumbu Kecap', 'harga': 45000, 'jumlah': 75},
          {'nama': 'Soto Ayam Medan', 'harga': 30000, 'jumlah': 75},
        ],
        'totalHarga': 5625000,
        'totalPorsi': 150,
        'statusPesanan': 'dikirim',
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'userId': 'demo-user-1',
        'namaCustomer': 'Dyren Sihombing',
        'nomorHp': '081234567801',
        'alamat': 'Jl. Sudirman No.12, Medan',
        'catatan': '',
        'tanggalPemesanan': Timestamp.fromDate(DateTime(2026, 4, 10)),
        'tanggalAcara': Timestamp.fromDate(DateTime(2026, 4, 20)),
        'items': [
          {'nama': 'Paket Nasi Box Hemat', 'harga': 25000, 'jumlah': 60},
        ],
        'totalHarga': 1500000,
        'totalPorsi': 60,
        'statusPesanan': 'selesai',
        'createdAt': FieldValue.serverTimestamp(),
      },
    ];

    for (final pesanan in pesananList) {
      try {
        await _db.collection('pesanan').add(pesanan);
        _addLog('Pesanan: ${pesanan['namaCustomer']}');
      } catch (e) {
        _addError('Pesanan: $e');
      }
    }
    setState(() => _loading = false);
  }

  // ==============================================================
  // 5. ISI DATA PEMBAYARAN (3 pembayaran)
  // ==============================================================
  Future<void> _isiDataPembayaran() async {
    setState(() {
      _loading = true;
      _log += '\n--- Mengisi Data Pembayaran ---';
    });

    // Ambil ID pesanan yang sudah ada
    final pesananSnap = await _db.collection('pesanan').limit(3).get();
    if (pesananSnap.docs.isEmpty) {
      _addError('Isi data pesanan dulu sebelum pembayaran!');
      setState(() => _loading = false);
      return;
    }

    final pembayaranList = [
      {
        'pesananId': pesananSnap.docs[0].id,
        'userId': 'demo-user-1',
        'namaCustomer': 'Dyren Sihombing',
        'nomorHp': '081234567801',
        'tanggalBayar': Timestamp.fromDate(DateTime(2026, 5, 29)),
        'jenisPembayaran': 'dp',
        'nominal': 1075000,
        'metodePembayaran': 'transfer',
        'bankEwallet': 'BCA',
        'buktiBayarUrl': '',
        'status': 'menunggu_verifikasi',
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'pesananId': pesananSnap.docs[1].id,
        'userId': 'demo-user-2',
        'namaCustomer': 'Rani Simanjuntak',
        'nomorHp': '081234567802',
        'tanggalBayar': Timestamp.fromDate(DateTime(2026, 5, 31)),
        'jenisPembayaran': 'lunas',
        'nominal': 8000000,
        'metodePembayaran': 'transfer',
        'bankEwallet': 'BRI',
        'buktiBayarUrl': '',
        'status': 'terverifikasi',
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'pesananId': pesananSnap.docs[2].id,
        'userId': 'demo-user-3',
        'namaCustomer': 'Budi Santoso',
        'nomorHp': '081234567803',
        'tanggalBayar': Timestamp.fromDate(DateTime(2026, 6, 2)),
        'jenisPembayaran': 'dp',
        'nominal': 2812500,
        'metodePembayaran': 'ewallet',
        'bankEwallet': 'GoPay',
        'buktiBayarUrl': '',
        'status': 'menunggu_verifikasi',
        'createdAt': FieldValue.serverTimestamp(),
      },
    ];

    for (final p in pembayaranList) {
      try {
        await _db.collection('pembayaran').add(p);
        _addLog('Pembayaran: ${p['namaCustomer']} (${p['jenisPembayaran']})');
      } catch (e) {
        _addError('Pembayaran: $e');
      }
    }
    setState(() => _loading = false);
  }

  // ==============================================================
  // 6. ISI DATA PEMBATALAN (2 pembatalan)
  // ==============================================================
  Future<void> _isiDataPembatalan() async {
    setState(() {
      _loading = true;
      _log += '\n--- Mengisi Data Pembatalan ---';
    });

    final pesananSnap = await _db.collection('pesanan').limit(2).get();
    if (pesananSnap.docs.isEmpty) {
      _addError('Isi data pesanan dulu!');
      setState(() => _loading = false);
      return;
    }

    final pembatalanList = [
      {
        'pesananId': pesananSnap.docs[0].id,
        'userId': 'demo-user-1',
        'namaCustomer': 'Dyren Sihombing',
        'nomorHp': '081234567801',
        'alasanPembatalan': 'Acara keluarga tiba-tiba dibatalkan',
        'tanggalPembatalan': Timestamp.fromDate(DateTime(2026, 5, 30)),
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      },
      {
        'pesananId': pesananSnap.docs[1].id,
        'userId': 'demo-user-2',
        'namaCustomer': 'Rani Simanjuntak',
        'nomorHp': '081234567802',
        'alasanPembatalan': 'Jumlah tamu berkurang drastis',
        'tanggalPembatalan': Timestamp.fromDate(DateTime(2026, 6, 1)),
        'status': 'disetujui',
        'createdAt': FieldValue.serverTimestamp(),
      },
    ];

    for (final p in pembatalanList) {
      try {
        await _db.collection('pembatalan').add(p);
        _addLog('Pembatalan: ${p['namaCustomer']} (${p['status']})');
      } catch (e) {
        _addError('Pembatalan: $e');
      }
    }
    setState(() => _loading = false);
  }

  // ==============================================================
  // 7. ISI DATA NOTIFIKASI (3 notifikasi)
  // ==============================================================
  Future<void> _isiDataNotifikasi() async {
    setState(() {
      _loading = true;
      _log += '\n--- Mengisi Data Notifikasi ---';
    });

    final notifList = [
      {
        'targetUserId': 'demo-user-1',
        'title': 'Pesanan Dikonfirmasi',
        'message':
            'Pesanan kamu telah dikonfirmasi oleh admin. Silakan lakukan pembayaran DP.',
        'type': 'pesanan',
        'isRead': false,
        'createdAt': Timestamp.fromDate(DateTime(2026, 5, 29, 9, 0)),
      },
      {
        'targetUserId': 'demo-user-2',
        'title': 'Pembayaran Terverifikasi',
        'message':
            'Pembayaran lunas kamu telah terverifikasi. Pesanan siap disiapkan.',
        'type': 'pembayaran',
        'isRead': true,
        'createdAt': Timestamp.fromDate(DateTime(2026, 5, 31, 14, 30)),
      },
      {
        'targetUserId': 'demo-user-1',
        'title': 'Ingatkan Pelunasan',
        'message':
            'Kamu masih memiliki sisa tagihan yang belum dilunasi. Segera lakukan pelunasan.',
        'type': 'tagihan',
        'isRead': false,
        'createdAt': Timestamp.fromDate(DateTime(2026, 6, 1, 10, 0)),
      },
    ];

    for (final n in notifList) {
      try {
        await _db.collection('notifikasi').add(n);
        _addLog('Notifikasi: ${n['title']}');
      } catch (e) {
        _addError('Notifikasi: $e');
      }
    }
    setState(() => _loading = false);
  }

  // ==============================================================
  // HELPER: pastikan ada user yang sedang login
  // ==============================================================
  Future<bool> _pastikanLogin() async {
    if (_auth.currentUser != null) return true;
    // Coba login sebagai admin
    try {
      await _auth.signInWithEmailAndPassword(
        email: 'admin@katering.com',
        password: 'admin123',
      );
      return true;
    } catch (_) {}
    // Kalau admin belum ada, coba pelanggan pertama
    try {
      await _auth.signInWithEmailAndPassword(
        email: 'dyren@gmail.com',
        password: 'pelanggan123',
      );
      return true;
    } catch (_) {}
    _addError('Tidak bisa login — buat akun dulu sebelum isi data!');
    return false;
  }

  // ==============================================================
  // SEED SEMUA SEKALIGUS
  // ==============================================================
  Future<void> _seedSemua() async {
    setState(() => _log = '=== MULAI SEED SEMUA DATA ===');
    // Step 1: buat akun dulu
    await _buatAkunAdmin();
    await _buatAkunPelanggan();
    // Step 2: pastikan login sebelum tulis data lain
    final loggedIn = await _pastikanLogin();
    if (!loggedIn) {
      setState(() => _log += '\n\n=== GAGAL: tidak bisa login ===');
      return;
    }
    _addLog('Login aktif sebagai: ${_auth.currentUser?.email}');
    await _isiDataMenu();
    await _isiDataPesanan();
    await _isiDataPembayaran();
    await _isiDataPembatalan();
    await _isiDataNotifikasi();
    setState(() => _log += '\n\n=== SELESAI ===');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2342B8),
        title: const Text('Seed Data Firebase',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // INFO AKUN
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📋 Akun yang akan dibuat:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('👑 Admin:     admin@katering.com  | admin123',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                  Text('👤 Pelanggan: dyren@gmail.com     | pelanggan123',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                  Text('👤 Pelanggan: rani@gmail.com      | pelanggan123',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                  Text('👤 Pelanggan: budi@gmail.com      | pelanggan123',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // TOMBOL SEED SEMUA
            ElevatedButton.icon(
              onPressed: _loading ? null : _seedSemua,
              icon: const Icon(Icons.rocket_launch, color: Colors.white),
              label: const Text('🚀 SEED SEMUA DATA SEKALIGUS',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2342B8),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),

            const SizedBox(height: 8),

            // TOMBOL INDIVIDUAL
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _seedBtn('Akun Admin', Colors.purple, _buatAkunAdmin),
                _seedBtn('Akun Pelanggan', Colors.blue, _buatAkunPelanggan),
                _seedBtn('Data Menu', Colors.green, _isiDataMenu),
                _seedBtn('Data Pesanan', Colors.orange, _isiDataPesanan),
                _seedBtn('Data Pembayaran', Colors.teal, _isiDataPembayaran),
                _seedBtn('Data Pembatalan', Colors.red, _isiDataPembatalan),
                _seedBtn('Data Notifikasi', Colors.indigo, _isiDataNotifikasi),
              ],
            ),

            const SizedBox(height: 12),

            // LOG OUTPUT
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _log.isEmpty ? 'Log akan muncul di sini...' : _log,
                    style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 12,
                        fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _seedBtn(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: _loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }
}
