import 'package:flutter/material.dart';
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

  List<Map<String, dynamic>> menuList = [
    {
      "image": "assets/ayam_panggang.png",
      "title": "Ayam Panggang",
      "desc": "Ayam panggang, dengan nasi, sop, sayur rebusan, dan jus",
      "price": 35000,
      "qty": 0,
    },
    {
      "image": "assets/babi_panggang.png",
      "title": "Babi Panggang",
      "desc": "Babi panggang, dengan nasi, sop, sayur daun ubi, aqua gelas",
      "price": 35000,
      "qty": 0,
    },
    {
      "image": "assets/babi_saksang.png",
      "title": "Saksang",
      "desc": "Saksang, dengan nasi, sop, sayur daun ubi, aqua gelas",
      "price": 35000,
      "qty": 0,
    },
    {
      "image": "assets/ayam_napinadar.png",
      "title": "Ayam Napinadar",
      "desc": "Ayam Napinadar, dengan nasi, sop, sayur rebusan, dan jus",
      "price": 35000,
      "qty": 0,
    },
    {
      "image": "assets/ikan_mas_arsik.png",
      "title": "Ikan Mas Arsik",
      "desc": "Ikan Mas Arsik, dengan nasi, sop, sayur daun ubi, aqua gelas",
      "price": 35000,
      "qty": 0,
    },
  ];

  // ================= LIST HASIL FILTER =================
  List<Map<String, dynamic>> filteredMenuList = [];

  List<Map<String, dynamic>> cartList = [];

  @override
  void initState() {
    super.initState();

    // awal tampil semua menu
    filteredMenuList = List.from(menuList);

    // listener search otomatis
    searchController.addListener(() {
      filterMenu(searchController.text);
    });
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
                                child: Image.asset(
                                  item['image'],
                                  width: 85,
                                  height: 85,
                                  fit: BoxFit.cover,
                                ),
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
}
