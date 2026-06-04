import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/firebase_service.dart';
import 'package:flutter_application_1/tambahpesanan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataPesananPage(),
    );
  }
}

class DataPesananPage extends StatefulWidget {
  const DataPesananPage({super.key});

  @override
  State<DataPesananPage> createState() => _DataPesananPageState();
}

class _DataPesananPageState extends State<DataPesananPage> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  // ======= DATA PESANAN DARI FIRESTORE =======
  // Tidak perlu hardcoded list — pakai StreamBuilder di bawah

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.025),
                decoration: BoxDecoration(
                  color: const Color(0xffD5DEE2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // TOMBOL KEMBALI
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: width * 0.05,
                      ),
                    ),

                    SizedBox(width: width * 0.02),

                    // TITLE
                    Expanded(
                      child: Text(
                        "Ridu Sianturi\nCatering",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    // PROFILE ADMIN
                    Column(
                      children: [
                        Container(
                          width: width * 0.10,
                          height: width * 0.10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/gambar_logo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: width * 0.005),
                        Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: width * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: width * 0.02),

              // DASHBOARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: width * 0.03,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffD5DEE2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: width * 0.05,
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: Text(
                        "Dasbord Admin/Mengelola Pesanan",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: width * 0.028,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: width * 0.02),

              // SEARCH + BUTTON
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: width * 0.10,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (v) => setState(() => searchQuery = v),
                        style: TextStyle(
                          fontSize: width * 0.028,
                        ),
                        decoration: InputDecoration(
                          hintText: "Cari Pesanan",
                          hintStyle: TextStyle(
                            fontSize: width * 0.028,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: width * 0.03,
                            vertical: width * 0.025,
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                            size: width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.02),

                  // TOMBOL TAMBAH
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TambahPesananPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: width * 0.10,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.025,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: width * 0.04,
                          ),
                          SizedBox(width: width * 0.01),
                          Text(
                            "Tambah",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.026,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: width * 0.025),

              Text(
                "Data Pesanan",
                style: TextStyle(
                  fontSize: width * 0.032,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: width * 0.02),

              // TABLE
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: width * 2.2,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: width * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffD9DDE0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              TableHeader(width: 40, title: "No."),
                              TableHeader(width: 80, title: "ID"),
                              TableHeader(width: 110, title: "Pelanggan"),
                              TableHeader(width: 90, title: "Pesanan"),
                              TableHeader(width: 90, title: "Acara"),
                              TableHeader(width: 100, title: "Alamat"),
                              TableHeader(width: 110, title: "Menu"),
                              TableHeader(width: 80, title: "Total"),
                              TableHeader(width: 60, title: "DP"),
                              TableHeader(width: 110, title: "Status"),
                            ],
                          ),
                        ),
                        SizedBox(height: width * 0.015),
                        Expanded(
                          // ======= DATA PESANAN REALTIME DARI FIRESTORE =======
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseService.streamSemuaPesanan(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text('Belum ada pesanan'));
                              }

                              final docs = snapshot.data!.docs.where((doc) {
                                final d = doc.data() as Map<String, dynamic>;
                                final nama = (d['namaCustomer'] ?? '')
                                    .toString()
                                    .toLowerCase();
                                final status = (d['statusPesanan'] ?? '')
                                    .toString()
                                    .toLowerCase();
                                final tglPesan = (d['tanggalPemesanan'] ?? '')
                                    .toString()
                                    .toLowerCase();
                                final q = searchQuery.toLowerCase();
                                return q.isEmpty ||
                                    nama.contains(q) ||
                                    status.contains(q) ||
                                    tglPesan.contains(q) ||
                                    doc.id.toLowerCase().contains(q);
                              }).toList();

                              return ListView.builder(
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  final doc = docs[index];
                                  final data =
                                      doc.data() as Map<String, dynamic>;
                                  final status =
                                      (data['statusPesanan'] ?? 'menunggu')
                                          .toString()
                                          .toLowerCase();
                                  Color statusColor = Colors.orange;
                                  if (status.contains('diproses')) {
                                    statusColor = Colors.green;
                                  } else if (status.contains('dikirim')) {
                                    statusColor = Colors.cyan;
                                  } else if (status.contains('selesai')) {
                                    statusColor = Colors.lightGreen;
                                  } else if (status.contains('batal')) {
                                    statusColor = Colors.red;
                                  }

                                  return Container(
                                    margin:
                                        EdgeInsets.only(bottom: width * 0.015),
                                    padding: EdgeInsets.symmetric(
                                        vertical: width * 0.02),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffD9DDE0),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        TableCellText(
                                            width: 40, text: '${index + 1}.'),
                                        TableCellText(
                                            width: 80,
                                            text: doc.id
                                                .substring(0, 6)
                                                .toUpperCase()),
                                        TableCellText(
                                            width: 110,
                                            text:
                                                '${data['namaCustomer'] ?? ''}\n${data['nomorHp'] ?? ''}'),
                                        TableCellText(
                                            width: 90,
                                            text:
                                                data['tanggalPemesanan'] ?? ''),
                                        TableCellText(
                                            width: 90,
                                            text: data['tanggalAcara'] ?? ''),
                                        TableCellText(
                                            width: 100,
                                            text: data['alamat'] ?? ''),
                                        TableCellText(
                                            width: 110,
                                            text:
                                                '${(data['items'] as List?)?.length ?? 0} menu\nx${data['totalPorsi'] ?? 0} porsi'),
                                        TableCellText(
                                            width: 80,
                                            text:
                                                'Rp.${data['totalHarga'] ?? 0}'),
                                        TableCellText(
                                            width: 60,
                                            text: data['statusPesanan'] ==
                                                    'menunggu_verifikasi_pembayaran'
                                                ? 'Ada DP'
                                                : '-'),
                                        // STATUS + UPDATE
                                        SizedBox(
                                          width: 110,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.01,
                                                  vertical: width * 0.01,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: statusColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  data['statusPesanan'] ?? '',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: width * 0.02,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: width * 0.01),
                                              // ======= UPDATE STATUS PESANAN =======
                                              if (status.contains('menunggu'))
                                                GestureDetector(
                                                  onTap: () async {
                                                    await FirebaseService
                                                        .updateStatusPesananDanNotif(
                                                      doc.id,
                                                      'diproses',
                                                      (data['userId'] ?? '')
                                                          .toString(),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Setujui',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.022,
                                                    ),
                                                  ),
                                                ),
                                              if (status.contains('diproses'))
                                                GestureDetector(
                                                  onTap: () async {
                                                    await FirebaseService
                                                        .updateStatusPesananDanNotif(
                                                      doc.id,
                                                      'dikirim',
                                                      (data['userId'] ?? '')
                                                          .toString(),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Kirim',
                                                    style: TextStyle(
                                                      color: Colors.cyan,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.022,
                                                    ),
                                                  ),
                                                ),
                                              if (status.contains('dikirim'))
                                                GestureDetector(
                                                  onTap: () async {
                                                    await FirebaseService
                                                        .updateStatusPesananDanNotif(
                                                      doc.id,
                                                      'selesai',
                                                      (data['userId'] ?? '')
                                                          .toString(),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Selesai',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.022,
                                                    ),
                                                  ),
                                                ),
                                              const SizedBox(height: 6),
                                              // Tampilkan bukti pembayaran jika ada
                                              if ((data['buktiBayarUrl'] ??
                                                      '') !=
                                                  '')
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        content: Image.network(
                                                            data[
                                                                'buktiBayarUrl']),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Lihat Bukti',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.02,
                                                    ),
                                                  ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HEADER TABLE
class TableHeader extends StatelessWidget {
  final double width;
  final String title;

  const TableHeader({
    super.key,
    required this.width,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.025,
        ),
      ),
    );
  }
}

// CELL TABLE
class TableCellText extends StatelessWidget {
  final double width;
  final String text;

  const TableCellText({
    super.key,
    required this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: screenWidth * 0.022,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
