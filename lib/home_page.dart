import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_application_1/firebase_service.dart';
import 'package:flutter_application_1/notifikasi_data.dart';
import 'package:flutter_application_1/notifikasi_page.dart';
import 'package:flutter_application_1/profil_page.dart';
import 'keranjang_page.dart';
import 'riwayat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  // ======= DATA MENU DARI FIRESTORE =======
  // menuList diisi oleh stream dari koleksi "menus" (status==aktif)
  // Fields Firestore: nama, deskripsi, harga (int), foto_url, kategori, stok
  List<Map<String, dynamic>> menuList = [];
  List<Map<String, dynamic>> filteredMenuList = [];
  List<Map<String, dynamic>> cartList = [];

  // StreamSubscription untuk menutup stream saat widget di-dispose
  StreamSubscription<QuerySnapshot>? _menuSubscription;

  @override
  void initState() {
    super.initState();

    // ======= SUBSCRIBE KE STREAM MENU FIRESTORE =======
    // Setiap ada perubahan di koleksi "menus", UI otomatis update
    _menuSubscription = FirebaseService.streamMenusAktif().listen((snapshot) {
      final data = snapshot.docs.map((doc) {
        final d = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'foto_url': d['foto_url'] ?? '',
          'title': d['nama'] ?? '',
          'desc': d['deskripsi'] ?? '',
          'price': d['harga'] ?? 0,
          'qty': 0,
          'stok': d['stok'] ?? 0,
        };
      }).toList();

      setState(() {
        menuList = data;
        filterMenu(searchController.text);
      });
    });

    // listener search otomatis
    searchController.addListener(() {
      filterMenu(searchController.text);
    });
  }

  @override
  void dispose() {
    _menuSubscription?.cancel();
    searchController.dispose();
    super.dispose();
  }

  // ================= FUNGSI SEARCH =================
  void filterMenu(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMenuList = List.from(menuList);
      } else {
        filteredMenuList = menuList.where((menu) {
          final title = menu['title'].toString().toLowerCase();
          final desc = menu['desc'].toString().toLowerCase();
          final search = query.toLowerCase();

          // cari berdasarkan nama menu atau deskripsi
          return title.contains(search) || desc.contains(search);
        }).toList();
      }
    });
  }

  void tambahKeKeranjang(int index) {
    setState(() {
      filteredMenuList[index]['qty']++;

      bool sudahAda = false;

      for (var item in cartList) {
        if (item['title'] == filteredMenuList[index]['title']) {
          item['qty'] = filteredMenuList[index]['qty'];
          sudahAda = true;
        }
      }

      if (!sudahAda) {
        cartList.add(filteredMenuList[index]);
      }
    });
  }

  void kurangKeranjang(int index) {
    setState(() {
      if (filteredMenuList[index]['qty'] > 0) {
        filteredMenuList[index]['qty']--;
      }

      cartList.removeWhere(
        (item) => item['qty'] == 0,
      );
    });
  }

  int totalItemKeranjang() {
    int total = 0;

    for (var item in cartList) {
      total += item['qty'] as int;
    }

    return total;
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
                onPressed: () {},
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RiwayatPage(),
                    ),
                  );
                },
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
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF1F1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    // ================= STATUS BAR =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "9:41",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.signal_cellular_alt),
                            const SizedBox(width: 5),
                            const Icon(Icons.wifi),
                            const SizedBox(width: 5),
                            Container(
                              width: 25,
                              height: 12,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ================= TITLE + ICON =================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65),
                            child: const Text(
                              "Ridu Sianturi\nCatering",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2347C6),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            // ================= CART =================
                            Stack(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KeranjangPage(
                                          cartList: cartList,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 32,
                                  ),
                                ),
                                if (totalItemKeranjang() > 0)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        "${totalItemKeranjang()}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(width: 10),

                            // ================= NOTIFICATION =================
                            Stack(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationPage(),
                                      ),
                                    );

                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.notifications_none,
                                    size: 32,
                                  ),
                                ),
                                if (daftarNotifikasi.isNotEmpty)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${daftarNotifikasi.length}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // ================= SEARCH BAR =================
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7FF),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF2347C6),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: searchController,

                                    // ================= AUTO SEARCH =================
                                    onChanged: (value) {
                                      filterMenu(value);
                                    },

                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.search,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.location_on_outlined,
                          size: 30,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 6),

            // ================= MENU LIST =================
            Expanded(
              child: filteredMenuList.isEmpty
                  ? const Center(
                      child: Text(
                        "Menu tidak ditemukan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredMenuList.length,
                      itemBuilder: (context, index) {
                        final item = filteredMenuList[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD7E0E5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                // ======= GAMBAR DARI FIRESTORE (foto_url) =======
                                // Jika foto_url kosong, tampilkan placeholder
                                child: item['foto_url'] != null &&
                                        (item['foto_url'] as String).isNotEmpty
                                    ? Image.network(
                                        item['foto_url'],
                                        width: 85,
                                        height: 85,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            _placeholderImage(),
                                      )
                                    : _placeholderImage(),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['desc'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Rp. ${item['price']}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ================= BUTTON QTY =================
                              Container(
                                height: 32,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7ED436),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        kurangKeranjang(index);
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "${item['qty']}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        tambahKeKeranjang(index);
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
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

  // ======= PLACEHOLDER IMAGE KETIKA foto_url KOSONG =======
  Widget _placeholderImage() {
    return Container(
      width: 85,
      height: 85,
      color: Colors.grey.shade300,
      child: const Icon(Icons.restaurant, size: 36, color: Colors.grey),
    );
  }
}
