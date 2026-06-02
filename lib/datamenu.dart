import 'package:flutter/material.dart';
import 'package:flutter_application_1/tambahmenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KelolaMenuPage(),
    );
  }
}

class KelolaMenuPage extends StatefulWidget {
  const KelolaMenuPage({super.key});

  @override
  State<KelolaMenuPage> createState() => _KelolaMenuPageState();
}

class _KelolaMenuPageState extends State<KelolaMenuPage> {
  final TextEditingController searchController = TextEditingController();
  String query = "";

  final List<Map<String, String>> menuList = [
    {
      "nama": "Ayam Panggang",
      "deskripsi": "Ayam panggang, dengan nasi, sop, sayur rebusan, dan jus",
      "harga": "Rp. 35.000",
      "gambar": "assets/ayam_panggang.png",
    },
    {
      "nama": "Babi Panggang",
      "deskripsi":
          "Babi panggang, dengan nasi, sop, sayur daun ubi, aqua gelas",
      "harga": "Rp. 35.000",
      "gambar": "assets/babi_panggang.png",
    },
    {
      "nama": "Ikan Mas Diura",
      "deskripsi": "Ikan mas ura, dengan nasi, lalapan",
      "harga": "Rp. 35.000",
      "gambar": "assets/ikan_mas_ura.png",
    },
    {
      "nama": "Ayam Penyet",
      "deskripsi": "Ayam penyet dengan nasi, lalapan, jus",
      "harga": "Rp. 35.000",
      "gambar": "assets/ayam_penyet.png",
    },
    {
      "nama": "Saksang",
      "deskripsi": "Saksang, dengan nasi, sop, sayur daun ubi, aqua gelas",
      "harga": "Rp. 35.000",
      "gambar": "assets/babi_saksang.png",
    },
    {
      "nama": "Ikan Mas Arsik",
      "deskripsi":
          "Ikan Mas Arsik, dengan nasi, sop, sayur daun ubi, aqua gelas",
      "harga": "Rp. 35.000",
      "gambar": "assets/ikan_mas_arsik.png",
    },
    {
      "nama": "Ayam Napinadar",
      "deskripsi": "Ayam Napinadar, dengan nasi, sop, sayur rebusan, dan jus",
      "harga": "Rp. 35.000",
      "gambar": "assets/ayam_napinadar.png",
    },
  ];

  List<Map<String, String>> get filteredMenu {
    if (query.isEmpty) return menuList;

    return menuList.where((item) {
      final nama = item["nama"]!.toLowerCase();
      return nama.contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffD8E1E6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back, size: 18),
                  ),
                  const SizedBox(width: 10),
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
                      const SizedBox(height: 4),
                      const Text(
                        "Admin",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // DASHBOARD
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffD8E1E6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.home_outlined, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Dasbord Admin/Mengelola menu",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // SEARCH & BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // SEARCH FIELD (SUDAH AKTIF)
                  Expanded(
                    child: Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff2447C6),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              query = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Cari Menu",
                            border: InputBorder.none,
                            isDense: true,
                            suffixIcon: Icon(Icons.search, size: 18),
                          ),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // TOMBOL TAMBAH
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TambahMenuPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 110,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xff2447C6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            "Tambah",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Data Menu",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // LIST MENU (SUDAH TERFILTER)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: filteredMenu.length,
                itemBuilder: (context, index) {
                  final item = filteredMenu[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xffD8E1E6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item["gambar"]!,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["nama"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item["deskripsi"]!,
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                item["harga"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
