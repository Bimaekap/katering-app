import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/firebase_service.dart';

void main() {
  runApp(const MyApp());
}

// ================= DATA NOTIFIKASI =================
List<Map<String, dynamic>> notifPelanggan = [];

// ================= MAIN APP =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HalamanSebelumnya(),
    );
  }
}

// ================= HALAMAN SEBELUMNYA =================
class HalamanSebelumnya extends StatelessWidget {
  const HalamanSebelumnya({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KelolaPembayaranPage(),
              ),
            );
          },
          child: const Text("Masuk Ke Kelola Pembayaran"),
        ),
      ),
    );
  }
}

// ================= HALAMAN KELOLA PEMBAYARAN =================
class KelolaPembayaranPage extends StatefulWidget {
  const KelolaPembayaranPage({super.key});

  @override
  State<KelolaPembayaranPage> createState() => _KelolaPembayaranPageState();
}

class _KelolaPembayaranPageState extends State<KelolaPembayaranPage> {
  // ================= SEARCH CONTROLLER =================
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  // ======= DATA PEMBAYARAN DARI FIRESTORE =======
  // Tidak perlu hardcoded list — pakai StreamBuilder di bawah

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() => searchQuery = searchController.text);
    });
  }

  // ================= FUNGSI INGATKAN =================
  void kirimNotifikasi(
    Map<String, dynamic> item,
  ) {
    // HANYA DP YANG BISA DIINGATKAN
    if (item["jenis"] != "DP") {
      return;
    }

    notifPelanggan.add({
      "nama": item["nama"],
      "id": item["id"],
      "tagihan": item["tagihan"],
      "status": item["status"],
    });

    // LANGSUNG KE HALAMAN NOTIFIKASI PELANGGAN
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotifikasiPelangganPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              // ================= HEADER =================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffd9dede),
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
                child: Row(
                  children: [
                    // ================= TOMBOL KEMBALI =================
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 15,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Expanded(
                      child: Text(
                        "Ridu Sianturi\nCatering",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff2342b8),
                        ),
                      ),
                    ),

                    // ================= FOTO ADMIN =================
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          backgroundImage: const AssetImage(
                            'assets/gambar_logo.png',
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Admin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ================= DASHBOARD =================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffd9dede),
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.home_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Dashboard ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: "Admin/Mengelola Pembayaran",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ================= SEARCH =================
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          6,
                        ),
                        border: Border.all(
                          color: const Color(0xff4b5ca8),
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari Nama / ID / Status",
                          hintStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 18,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 34,
                    width: 95,
                    decoration: BoxDecoration(
                      color: const Color(0xff2342b8),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Filter",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10),

              // ================= JUDUL =================
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Data Pembayaran",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ================= TABLE =================
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 620,
                    child: Column(
                      children: [
                        // ================= HEADER TABLE =================
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffd9dede),
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          child: Row(
                            children: const [
                              TableHeader(
                                title: "NO",
                                width: 35,
                              ),
                              TableHeader(
                                title: "ID",
                                width: 80,
                              ),
                              TableHeader(
                                title: "Nama",
                                width: 110,
                              ),
                              TableHeader(
                                title: "Tanggal",
                                width: 85,
                              ),
                              TableHeader(
                                title: "Jenis",
                                width: 55,
                              ),
                              TableHeader(
                                title: "Tagihan",
                                width: 110,
                              ),
                              TableHeader(
                                title: "Aksi",
                                width: 145,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        // ======= DATA PEMBAYARAN REALTIME DARI FIRESTORE =======
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseService.streamSemuaPembayaran(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text('Belum ada data pembayaran'));
                              }

                              final docs = snapshot.data!.docs.where((doc) {
                                final d = doc.data() as Map<String, dynamic>;
                                final nama = (d['namaCustomer'] ?? '')
                                    .toString()
                                    .toLowerCase();
                                final status = (d['status'] ?? '')
                                    .toString()
                                    .toLowerCase();
                                final q = searchQuery.toLowerCase();
                                return q.isEmpty ||
                                    nama.contains(q) ||
                                    status.contains(q) ||
                                    doc.id.toLowerCase().contains(q);
                              }).toList();

                              return ListView.builder(
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  final doc = docs[index];
                                  final item =
                                      doc.data() as Map<String, dynamic>;
                                  final isDP = item['jenisPembayaran'] == 'dp';
                                  final statusTxt =
                                      item['status'] ?? 'menunggu_verifikasi';
                                  Color warna = statusTxt.contains('menunggu')
                                      ? const Color(0xfff4c16d)
                                      : const Color(0xff6ddc4f);

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffd9dede),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        TableCellWidget(
                                            text: '${index + 1}.', width: 35),
                                        TableCellWidget(
                                            text: doc.id
                                                .substring(0, 6)
                                                .toUpperCase(),
                                            width: 80,
                                            bold: true),
                                        SizedBox(
                                          width: 110,
                                          child: Column(
                                            children: [
                                              Text(
                                                item['namaCustomer'] ?? '',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11),
                                              ),
                                              Text(
                                                item['nomorHp'] ?? '',
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TableCellWidget(
                                            text: item['tanggalBayar'] != null
                                                ? (item['tanggalBayar']
                                                        as Timestamp)
                                                    .toDate()
                                                    .toString()
                                                    .substring(0, 10)
                                                : '-',
                                            width: 85,
                                            bold: true),
                                        TableCellWidget(
                                            text: isDP ? 'DP' : 'Lunas',
                                            width: 55),
                                        TableCellWidget(
                                            text: 'Rp.${item['nominal'] ?? 0}',
                                            width: 110,
                                            bold: true),
                                        // ======= AKSI: VERIFIKASI / INGATKAN =======
                                        SizedBox(
                                          width: 145,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: warna,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  statusTxt,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              if (statusTxt
                                                  .contains('menunggu'))
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        // ======= VERIFIKASI PEMBAYARAN =======
                                                        await FirebaseService
                                                            .updateStatusPembayaran(
                                                                doc.id,
                                                                'terverifikasi');
                                                      },
                                                      child: const Text(
                                                        'Verifikasi',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    InkWell(
                                                      onTap: () async {
                                                        await FirebaseService
                                                            .updateStatusPembayaran(
                                                                doc.id,
                                                                'ditolak');
                                                      },
                                                      child: const Text(
                                                        'Tolak',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              else
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.check_circle,
                                                        color: Colors.green,
                                                        size: 15),
                                                    SizedBox(width: 5),
                                                    Text('Lunas',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10)),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        // ================= FOOTER =================
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffd9dede),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                "Data Pembayaran (realtime)",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Selanjutnya >",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ================= HALAMAN NOTIFIKASI =================
class NotifikasiPelangganPage extends StatelessWidget {
  const NotifikasiPelangganPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: const Color(0xff2342b8),
        title: const Text(
          "Notifikasi Pelanggan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: notifPelanggan.isEmpty
          ? const Center(
              child: Text(
                "Belum ada notifikasi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: notifPelanggan.length,
              itemBuilder: (context, index) {
                final notif = notifPelanggan[index];

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  padding: const EdgeInsets.all(
                    12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notif["nama"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "ID Pesanan : ${notif["id"]}",
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Jumlah Tagihan : ${notif["tagihan"]}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Status : ${notif["status"]}",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Segera lakukan pembayaran sebelum jatuh tempo.",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}

// ================= HEADER TABLE =================
class TableHeader extends StatelessWidget {
  final String title;
  final double width;

  const TableHeader({
    super.key,
    required this.title,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }
}

// ================= CELL TABLE =================
class TableCellWidget extends StatelessWidget {
  final String text;
  final double width;
  final bool bold;

  const TableCellWidget({
    super.key,
    required this.text,
    required this.width,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}
