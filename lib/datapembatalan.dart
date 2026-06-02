import 'package:flutter/material.dart';

// ================= DATA NOTIFIKASI USER =================
class NotificationService {
  static List<Map<String, String>> notifications = [];

  static void addNotification({
    required String title,
    required String message,
  }) {
    notifications.insert(0, {
      "title": title,
      "message": message,
      "time": DateTime.now().toString(),
    });
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KelolaPembatalanPage(),
    );
  }
}

class KelolaPembatalanPage extends StatefulWidget {
  const KelolaPembatalanPage({super.key});

  @override
  State<KelolaPembatalanPage> createState() => _KelolaPembatalanPageState();
}

class _KelolaPembatalanPageState extends State<KelolaPembatalanPage> {
  final TextEditingController searchController = TextEditingController();

  final ScrollController horizontalController = ScrollController();

  final List<Map<String, dynamic>> dataPembatalan = [
    {
      "no": "1.",
      "id": "ORD006",
      "nama": "Marlina",
      "hp": "08212121121",
      "tanggal": "20-03-2026",
      "alasan": "Acara keluarga dibatalkan",
      "status": "pending",
    },
    {
      "no": "2.",
      "id": "ORD007",
      "nama": "Mina",
      "hp": "08212121129",
      "tanggal": "18-03-2026",
      "alasan": "Pesanan salah menu",
      "status": "ditolak",
    },
    {
      "no": "3.",
      "id": "ORD008",
      "nama": "Intan",
      "hp": "08212121123",
      "tanggal": "19-03-2026",
      "alasan": "Lokasi acara berubah",
      "status": "disetujui",
    },
    {
      "no": "4.",
      "id": "ORD009",
      "nama": "Joko",
      "hp": "08212121125",
      "tanggal": "20-03-2026",
      "alasan": "Jumlah tamu berkurang",
      "status": "disetujui",
    },
  ];

  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();

    // DATA AWAL LANGSUNG MUNCUL
    filteredData = List.from(dataPembatalan);
  }

  @override
  void dispose() {
    horizontalController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void searchData(String keyword) {
    setState(() {
      filteredData = dataPembatalan.where((item) {
        final nama = item['nama'].toString().toLowerCase();
        final id = item['id'].toString().toLowerCase();
        final input = keyword.toLowerCase();

        return nama.contains(input) || id.contains(input);
      }).toList();
    });
  }

  void approveCancellation(int index) {
    setState(() {
      filteredData[index]['status'] = "disetujui";
    });

    NotificationService.addNotification(
      title: "Pembatalan Disetujui",
      message:
          "Permintaan pembatalan pesanan ${filteredData[index]['id']} telah disetujui admin.",
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Pembatalan berhasil disetujui & notifikasi dikirim ke user",
        ),
      ),
    );
  }

  void rejectCancellation(int index) {
    setState(() {
      filteredData[index]['status'] = "ditolak";
    });

    NotificationService.addNotification(
      title: "Pembatalan Ditolak",
      message:
          "Permintaan pembatalan pesanan ${filteredData[index]['id']} ditolak admin.",
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Pembatalan berhasil ditolak & notifikasi dikirim ke user",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // ================= HEADER =================
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffD9E1E5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(width: 8),

                    const Expanded(
                      child: Text(
                        "Ridu Sianturi\nCatering",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2144D0),
                        ),
                      ),
                    ),

                    // FOTO ADMIN
                    Column(
                      children: [
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
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
                                  size: 18,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= BREADCRUMB =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffD9E1E5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Admin / Mengelola Pembatalan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ================= SEARCH =================
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff2144D0),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) {
                                searchData(value);
                              },
                              style: const TextStyle(
                                fontSize: 11,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Cari Nama/ID",
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.search,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ================= TABLE =================
              Expanded(
                child: Scrollbar(
                  controller: horizontalController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 760,
                      child: Column(
                        children: [
                          // HEADER TABLE
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffD9E1E5),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: const Row(
                              children: [
                                TableHeader(
                                  title: "No",
                                  width: 40,
                                ),
                                TableHeader(
                                  title: "ID",
                                  width: 70,
                                ),
                                TableHeader(
                                  title: "Pelanggan",
                                  width: 120,
                                ),
                                TableHeader(
                                  title: "Tanggal",
                                  width: 90,
                                ),
                                TableHeader(
                                  title: "Alasan",
                                  width: 180,
                                ),
                                TableHeader(
                                  title: "Status",
                                  width: 100,
                                ),
                                TableHeader(
                                  title: "Aksi",
                                  width: 160,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // DATA TABLE
                          Expanded(
                            child: ListView.builder(
                              itemCount: filteredData.length,
                              itemBuilder: (context, index) {
                                final item = filteredData[index];

                                return Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xffEEF2F5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      TableCellText(
                                        text: item['no'],
                                        width: 40,
                                      ),

                                      TableCellText(
                                        text: item['id'],
                                        width: 70,
                                      ),

                                      TableCellText(
                                        text: "${item['nama']}\n${item['hp']}",
                                        width: 120,
                                      ),

                                      TableCellText(
                                        text: item['tanggal'],
                                        width: 90,
                                      ),

                                      TableCellText(
                                        text: item['alasan'],
                                        width: 180,
                                      ),

                                      // STATUS
                                      SizedBox(
                                        width: 100,
                                        child: Center(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: item['status'] == "pending"
                                                  ? Colors.orange
                                                  : item['status'] ==
                                                          "disetujui"
                                                      ? Colors.green
                                                      : Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                6,
                                              ),
                                            ),
                                            child: Text(
                                              item['status'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // BUTTON AKSI
                                      SizedBox(
                                        width: 160,
                                        child: item['status'] == "pending"
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      approveCancellation(
                                                          index);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                      minimumSize: const Size(
                                                        60,
                                                        30,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Setuju",
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      rejectCancellation(index);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      minimumSize: const Size(
                                                        60,
                                                        30,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Tolak",
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : const Center(
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= HEADER TABLE =================
class TableHeader extends StatelessWidget {
  final String title;
  final double width;

  const TableHeader({
    super.key,
    required this.title,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ================= CELL TABLE =================
class TableCellText extends StatelessWidget {
  final String text;
  final double width;

  const TableCellText({
    super.key,
    required this.text,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
