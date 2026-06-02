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
      theme: ThemeData(
        fontFamily: 'Sans-Serif',
      ),
      home: const TambahPesananPage(),
    );
  }
}

class TambahPesananPage extends StatefulWidget {
  const TambahPesananPage({super.key});

  @override
  State<TambahPesananPage> createState() => _TambahPesananPageState();
}

class _TambahPesananPageState extends State<TambahPesananPage> {
  // ================= CONTROLLER =================
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tglPesanController = TextEditingController();
  final TextEditingController tglAcaraController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController menuController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // TANPA SCROLL
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              color: const Color(0xFFD0D7DE),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TOMBOL KEMBALI
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 22,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Ridu Sianturi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B52B4),
                          ),
                        ),
                        Text(
                          'Catering',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B52B4),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // PROFILE ADMIN IMAGE ASSET
                  Column(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            "assets/gambar_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ================= CONTENT =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // DASHBOARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC1C9D2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: Colors.black87,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Dasbord ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'menambahkan pesanan',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // TITLE
                    const Text(
                      'Tambahkan Pesanan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      'Lengkapi informasi pesanan baru',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // INPUTS
                    Expanded(
                      child: Column(
                        children: [
                          _buildInputField(
                            'Nama Pemesan',
                            'Masukkan nama',
                            namaController,
                          ),
                          _buildInputField(
                            'Tanggal pesan',
                            'Masukkan tanggal pesan',
                            tglPesanController,
                          ),
                          _buildInputField(
                            'Tanggal acara',
                            'Masukkan tanggal acara',
                            tglAcaraController,
                          ),
                          _buildInputField(
                            'Alamat',
                            'Tambahkan alamat',
                            alamatController,
                          ),
                          _buildInputField(
                            'Jenis Menu',
                            'Masukkan Jenis menu',
                            menuController,
                          ),
                          _buildInputField(
                            'Jumlah pesanan',
                            'Masukkan jumlah pesanan',
                            jumlahController,
                          ),
                          _buildInputField(
                            'Total Harga',
                            'Masukkan total harga',
                            totalController,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // BUTTONS
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6F828A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // TOMBOL SIMPAN
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1D4ED8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                // DATA PESANAN BARU
                                final Map<String, dynamic> pesananBaru = {
                                  "nama": namaController.text,
                                  "tglPesanan": tglPesanController.text,
                                  "tglAcara": tglAcaraController.text,
                                  "alamat": alamatController.text,
                                  "menu":
                                      "${menuController.text}\nx ${jumlahController.text}",
                                  "total": totalController.text,
                                };

                                // KIRIM DATA KE HALAMAN SEBELUMNYA
                                Navigator.pop(context, pesananBaru);
                              },
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
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
          ],
        ),
      ),
    );
  }

  // ================= INPUT FIELD =================
  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
