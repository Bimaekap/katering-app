import 'package:flutter/material.dart';
import 'package:flutter_application_1/Welcome.dart';
import 'package:flutter_application_1/datamenu.dart';
import 'package:flutter_application_1/datapelanggan.dart';
import 'package:flutter_application_1/datapembatalan.dart';
import 'package:flutter_application_1/datapembayaran.dart';
import 'package:flutter_application_1/datapesanan.dart';
import 'package:flutter_application_1/laporankeuangan.dart';
import 'package:flutter_application_1/laporanpembayaran.dart';
import 'package:flutter_application_1/laporanpesanan.dart';
import 'package:flutter_application_1/laporanpiutang.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SansSerif',
      ),
      home: const HomeAdminPage(),
    );
  }
}

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color headerBlue = Color(0xFFC7D4FF);
    const Color cardBeige = Color(0xFFDCCDBB);
    const Color textBlue = Color(0xFF1A3D8A);
    const Color bgGrey = Color(0xFFF5F5F7);
    const Color barGrey = Color(0xFFE0E0E0);

    return Scaffold(
      backgroundColor: bgGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            children: [
              // ================= HEADER =================
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: headerBlue,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        "Ridu Sianturi\nCatering",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textBlue,
                        ),
                      ),
                    ),

                    // ================= FOTO ADMIN =================
                    Column(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            child: Image.asset(
                              "assets/gambar_logo.png",
                              fit: BoxFit.cover,
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return const Icon(
                                  Icons.image_not_supported,
                                  size: 24,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= DASHBOARD BAR =================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: barGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      size: 24,
                    ),

                    const SizedBox(width: 8),

                    const Expanded(
                      child: Text(
                        "Dashboard Admin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    // ================= LOGOUT =================
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomePage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const KelolaPembatalanPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.cancel_outlined,
                          "Data Pembatalan",
                          cardBeige,
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KelolaPelangganPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.person_outline,
                          "Data Pelanggan",
                          cardBeige,
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KelolaMenuPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.restaurant_menu,
                          "Data Menu",
                          cardBeige,
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DataPesananPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.shopping_cart_outlined,
                          "Data Pesanan",
                          cardBeige,
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const KelolaPembayaranPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.payments_outlined,
                          "Data Pembayaran",
                          cardBeige,
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LaporanPesananPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.assessment_outlined,
                          "Laporan Pemesanan",
                          cardBeige,
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LaporanPembayaranPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.account_balance_wallet_outlined,
                          "Laporan Pembayaran",
                          cardBeige,
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LaporanPiutangPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.query_stats,
                          "Laporan Piutang",
                          cardBeige,
                        ),
                      ),
                    ),

                    // ================= LAPORAN KEUANGAN =================
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LaporanKeuanganPage(),
                            ),
                          );
                        },
                        child: _buildMenuTile(
                          Icons.assignment_outlined,
                          "Laporan Keuangan",
                          cardBeige,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile(
    IconData icon,
    String title,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 6,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.04,
            ),
            blurRadius: 3,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 18,
          ),
        ],
      ),
    );
  }
}
