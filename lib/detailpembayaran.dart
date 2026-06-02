import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const VerifikasiPembayaranPage(),
    );
  }
}

class VerifikasiPembayaranPage extends StatelessWidget {
  const VerifikasiPembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // =========================
              // TITLE
              // =========================
              const Text(
                'Infomasi Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 22),

              // =========================
              // DETAIL PEMBAYARAN
              // =========================
              buildRow(
                'Metode pembayaran',
                'Transfer BRI',
              ),

              buildRow(
                'Nama Pengirim',
                'Dyren',
              ),

              buildRow(
                'Bank Pengirim',
                'BRI',
              ),

              buildRow(
                'Nominal Transfer',
                'Rp.1.675.000',
              ),

              buildRow(
                'No.Referensi',
                'FT240421103045',
              ),

              buildRow(
                'Catatan dari pelanggan',
                'Pembayaran uang\nmuka catering',
              ),

              const SizedBox(height: 28),

              // =========================
              // TITLE BUKTI
              // =========================
              const Text(
                'Infomasi Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 22),

              // =========================
              // FOTO BUKTI TRANSFER
              // =========================
              Center(
                child: Container(
                  width: 120,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/bukti_transfer.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // =========================
              // BUTTON
              // =========================
              // =========================
// BUTTON
// =========================
              Row(
                children: [
                  // TOLAK
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          // kirim status ditolak ke halaman sebelumnya
                          Navigator.pop(context, "Ditolak");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Tolak',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  // VERIFIKASI
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          // kirim status diverifikasi ke halaman sebelumnya
                          Navigator.pop(context, "Diproses");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1F4ACC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Verifikasi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // CUSTOM ROW
  // =========================
  Widget buildRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
