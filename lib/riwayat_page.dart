import 'package:flutter/material.dart';
import 'package:flutter_application_1/detailpesanan_page.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/profil_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RiwayatPage(),
    );
  }
}

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  // DATA PESANAN
  final List<Map<String, dynamic>> riwayatPesanan = [
    {
      "title": "2 Menu",
      "date": DateTime.now(),
    },
    {
      "title": "1 Menu",
      "date": DateTime.now().subtract(
        const Duration(days: 3),
      ),
    },
    {
      "title": "3 Menu",
      "date": DateTime.now().subtract(
        const Duration(days: 15),
      ),
    },
  ];

  // FORMAT BULAN
  String getNamaBulan(int month) {
    List<String> bulan = [
      "",
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    return bulan[month];
  }

  // FORMAT TANGGAL
  String formatTanggal(DateTime date) {
    return "${date.day} ${getNamaBulan(date.month)} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // ================= BOTTOM NAVIGATION =================
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 58,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.only(bottom: 6),
          decoration: const BoxDecoration(
            color: Color(0xFFEFF1F1),
            border: Border(
              top: BorderSide(
                color: Color(0xFF2347C6),
                width: 1.8,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ================= HOME =================
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.home,
                  size: 22,
                  color: Colors.black,
                ),
              ),

              // ================= RIWAYAT =================
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
                icon: const Icon(
                  Icons.receipt_long,
                  size: 22,
                  color: Colors.black,
                ),
              ),

              // ================= PROFILE =================
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  size: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              child: Row(
                children: [
                  // BACK BUTTON
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6ED43A),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        "Riwayat",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 46),
                ],
              ),
            ),

            // ================= LIST RIWAYAT =================
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: riwayatPesanan.length,
                itemBuilder: (context, index) {
                  final item = riwayatPesanan[index];

                  DateTime tanggal = item['date'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= NAMA BULAN =================
                      if (index == 0 ||
                          riwayatPesanan[index - 1]['date'].month !=
                              tanggal.month)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text(
                            getNamaBulan(tanggal.month),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      // ================= CARD RIWAYAT =================
                      GestureDetector(
                        onTap: () {
                          // NAVIGATOR KE DETAIL PESANAN
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetailPesananPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 14,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.05,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // ================= ICON =================
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFE8F5E9,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.fastfood,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),

                              const SizedBox(width: 14),

                              // ================= TEXT =================
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // TITLE
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    // TANGGAL
                                    Text(
                                      formatTanggal(tanggal),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ================= ARROW =================
                              const Icon(
                                Icons.chevron_right,
                                size: 28,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
