import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TambahMenuPage(),
    );
  }
}

class TambahMenuPage extends StatefulWidget {
  const TambahMenuPage({super.key});

  @override
  State<TambahMenuPage> createState() => _TambahMenuPageState();
}

class _TambahMenuPageState extends State<TambahMenuPage> {
  // ================= CONTROLLER INPUT =================
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    kategoriController.dispose();
    hargaController.dispose();
    super.dispose();
  }

  // ================= SIMPAN MENU KE FIRESTORE =================
  // Dipanggil saat tombol "Simpan Menu" ditekan
  // Menyimpan dokumen baru ke koleksi "menus" di Firestore
  void simpanMenu() async {
    final nama = namaController.text.trim();
    final kategori = kategoriController.text.trim();
    final hargaStr = hargaController.text.trim();

    if (nama.isEmpty || kategori.isEmpty || hargaStr.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama, kategori, dan harga wajib diisi')),
      );
      return;
    }

    final harga = int.tryParse(hargaStr) ?? 0;

    await FirebaseService.tambahMenu(
      nama: nama,
      deskripsi: '',
      harga: harga,
      kategori: kategori,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Menu berhasil disimpan ke Firestore')),
    );

    Navigator.pop(context, {
      "nama": nama,
      "kategori": kategori,
      "harga": "Rp. $hargaStr",
    });
  }

  // ================= BATAL =================
  void batal() {
    namaController.clear();
    kategoriController.clear();
    hargaController.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // ================= HEADER =================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffD8E1E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 20),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Ridu Sianturi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2447C6),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Catering",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2447C6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xff2447C6),
                              width: 1.5,
                            ),
                            image: const DecorationImage(
                              image: AssetImage("assets/gambar_logo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= DASHBOARD =================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffD8E1E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.home_outlined, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Dasbord menambahkan menu",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tambah Menu Baru",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Lengkapi informasi menu baru",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 14),

              // ================= INPUT =================
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Nama Menu"),
              ),
              const SizedBox(height: 5),
              Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xffD8E1E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Kategori"),
              ),
              const SizedBox(height: 5),
              Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xffD8E1E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: kategoriController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Harga"),
              ),
              const SizedBox(height: 5),
              Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xffD8E1E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text("Rp"),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: hargaController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ================= GAMBAR MENU (ICON CUSTOM) =================
              Container(
                height: 140,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffD5CEC2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud_upload_outlined,
                        size: 40,
                        color: Color(0xff2447C6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text("Klik untuk upload gambar"),
                    const Text("JPG, PNG, max 10 mb"),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ================= BUTTON =================
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: batal,
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xff6D8F98),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Batal")),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: GestureDetector(
                      onTap: simpanMenu,
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xff2447C6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Simpan Menu",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
