import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/notifikasi_data.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PembatalanDiprosesPage(),
    );
  }
}

class PembatalanDiprosesPage extends StatefulWidget {
  const PembatalanDiprosesPage({super.key});

  @override
  State<PembatalanDiprosesPage> createState() =>
      _PembatalanDiprosesPageState();
}

class _PembatalanDiprosesPageState
    extends State<PembatalanDiprosesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> scaleAnimation;
  late Animation<double> rotateAnimation;
  late Animation<double> opacityAnimation;

  // ================= AGAR NOTIFIKASI TIDAK DOUBLE =================
  bool sudahTambahNotif = false;

  @override
  void initState() {
    super.initState();

    // ================= TAMBAH NOTIFIKASI OTOMATIS =================
    if (!sudahTambahNotif) {
      daftarNotifikasi.insert(0, {
        "title": "Pembatalan Pesanan",
        "message":
            "Pembatalan pesanan sedang diproses admin. Mohon tunggu konfirmasi.",
        "icon": Icons.cancel,
        "color": Colors.red,
        "date": DateTime.now(),
      });

      sudahTambahNotif = true;
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    scaleAnimation = Tween<double>(
      begin: 0.2,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    rotateAnimation = Tween<double>(
      begin: -0.5,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final circleSize = screenWidth * 0.45;
    final iconSize = screenWidth * 0.24;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      bottomNavigationBar: const SizedBox(),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ================= ICON =================
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: opacityAnimation.value,
                      child: Transform.scale(
                        scale: scaleAnimation.value,
                        child: Transform.rotate(
                          angle: rotateAnimation.value,
                          child: Container(
                            width: circleSize,
                            height: circleSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFFD54F),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  blurRadius: 15,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check_rounded,
                                size: iconSize,
                                color: const Color(0xFF4CAF50),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 35),

                // ================= TITLE =================
                Text(
                  "Pembatalan Pesanan Anda Sedang Diproses",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF28D3A7),
                  ),
                ),

                const SizedBox(height: 16),

                // ================= DESCRIPTION =================
                Text(
                  "Pembatalan pesanan anda sedang menunggu konfirmasi dari admin,\nsilakan menunggu maksimal 1x24 jam.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 45),

                // ================= BUTTON =================
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF62D323),
                      elevation: 5,
                      shadowColor: Colors.green.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Kembali ke Beranda",
                      style: TextStyle(
                        fontSize: screenWidth * 0.030,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}