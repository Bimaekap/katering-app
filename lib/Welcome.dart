import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page.dart';
import 'register_page.dart';
import 'seed_data_page.dart'; // ← SEED DATA (hapus import ini setelah selesai)

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ukuran layar
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.06),

                // Gambar
                Center(
                  child: Image.asset(
                    'assets/gambar_logo.png',
                    height: size.height * 0.25,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: size.height * 0.05),

                // Text Welcome
                const Text(
                  'Selamat Datang\nKe\nRidu Sianturi\nCatering',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E40D0),
                    height: 1.4,
                  ),
                ),

                const Spacer(),

                // Tombol
                Row(
                  children: [
                    // Tombol Masuk
                    Expanded(
                      child: SizedBox(
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2340C7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // Tombol Daftar
                    Expanded(
                      child: SizedBox(
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 52, 187, 224),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.07),

                // ===== TOMBOL SEED DATA (HAPUS SETELAH TESTING) =====
                TextButton.icon(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SeedDataPage())),
                  icon: const Icon(Icons.storage, size: 14, color: Colors.grey),
                  label: const Text('Dev: Isi Data Testing',
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
