import 'package:flutter/material.dart';
import 'package:flutter_application_1/detailpembayaran.dart';
import 'package:flutter_application_1/tambahpesanan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataPesananPage(),
    );
  }
}

class DataPesananPage extends StatefulWidget {
  const DataPesananPage({super.key});

  @override
  State<DataPesananPage> createState() => _DataPesananPageState();
}

class _DataPesananPageState extends State<DataPesananPage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> allPesanan = [
    {
      "no": "1.",
      "id": "ORD001",
      "nama": "Yanto",
      "hp": "08212121121",
      "tglPesanan": "20-04-2026",
      "tglAcara": "28-04-2026",
      "alamat": "Jl. Mahoni.12",
      "menu": "Napinadar\nx 500 piring",
      "total": "10.000.000",
      "dp": "3.000.000",
      "status": "Menunggu\nKonfirmasi",
      "statusColor": Colors.orange,
    },
    {
      "no": "2.",
      "id": "ORD002",
      "nama": "Ainun",
      "hp": "08212121121",
      "tglPesanan": "23-03-2026",
      "tglAcara": "22-03-2026",
      "alamat": "Jl.Perjuangan",
      "menu": "Rendang\nx 200 piring",
      "total": "5.000.000",
      "dp": "-",
      "status": "Dikirim",
      "statusColor": Colors.cyan,
    },
    {
      "no": "3.",
      "id": "ORD003",
      "nama": "Ruslita",
      "hp": "08212121121",
      "tglPesanan": "20-04-2026",
      "tglAcara": "27-04-2026",
      "alamat": "Jl. Aggrek",
      "menu": "Ayam penyet\nx 100 Kotak",
      "total": "2.000.000",
      "dp": "600.000",
      "status": "Diproses",
      "statusColor": Colors.green,
    },
    {
      "no": "4.",
      "id": "ORD004",
      "nama": "Marco",
      "hp": "08212121121",
      "tglPesanan": "03-04-2026",
      "tglAcara": "10-04-2026",
      "alamat": "Jl.Perintis no.2",
      "menu": "Ayam penyet\nx 100 Kotak",
      "total": "2.000.000",
      "dp": "-",
      "status": "Selesai",
      "statusColor": Colors.lightGreen,
    },
    {
      "no": "5.",
      "id": "ORD005",
      "nama": "Budi",
      "hp": "081398765432",
      "tglPesanan": "05-05-2026",
      "tglAcara": "12-05-2026",
      "alamat": "Jl. Sakura",
      "menu": "Sate Ayam\nx 300 porsi",
      "total": "4.500.000",
      "dp": "1.500.000",
      "status": "Diproses",
      "statusColor": Colors.green,
    },
    {
      "no": "6.",
      "id": "ORD006",
      "nama": "Siska",
      "hp": "082112223333",
      "tglPesanan": "11-05-2026",
      "tglAcara": "18-05-2026",
      "alamat": "Jl. Melati",
      "menu": "Nasi Kotak\nx 150 kotak",
      "total": "3.000.000",
      "dp": "1.000.000",
      "status": "Selesai",
      "statusColor": Colors.lightGreen,
    },
  ];

  List<Map<String, dynamic>> filteredPesanan = [];

  @override
  void initState() {
    super.initState();
    filteredPesanan = allPesanan;
  }

  void searchPesanan(String query) {
    final hasil = allPesanan.where((data) {
      final id = data["id"].toString().toLowerCase();
      final nama = data["nama"].toString().toLowerCase();
      final tglPesanan = data["tglPesanan"].toString().toLowerCase();
      final tglAcara = data["tglAcara"].toString().toLowerCase();
      final alamat = data["alamat"].toString().toLowerCase();
      final status = data["status"].toString().toLowerCase();

      final input = query.toLowerCase();

      return id.contains(input) ||
          nama.contains(input) ||
          tglPesanan.contains(input) ||
          tglAcara.contains(input) ||
          alamat.contains(input) ||
          status.contains(input);
    }).toList();

    setState(() {
      filteredPesanan = hasil;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.025),
                decoration: BoxDecoration(
                  color: const Color(0xffD5DEE2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // TOMBOL KEMBALI
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: width * 0.05,
                      ),
                    ),

                    SizedBox(width: width * 0.02),

                    // TITLE
                    Expanded(
                      child: Text(
                        "Ridu Sianturi\nCatering",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    // PROFILE ADMIN
                    Column(
                      children: [
                        Container(
                          width: width * 0.10,
                          height: width * 0.10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/gambar_logo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: width * 0.005),
                        Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: width * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: width * 0.02),

              // DASHBOARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: width * 0.03,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffD5DEE2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: width * 0.05,
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: Text(
                        "Dasbord Admin/Mengelola Pesanan",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: width * 0.028,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: width * 0.02),

              // SEARCH + BUTTON
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: width * 0.10,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: searchPesanan,
                        style: TextStyle(
                          fontSize: width * 0.028,
                        ),
                        decoration: InputDecoration(
                          hintText: "Cari Pesanan",
                          hintStyle: TextStyle(
                            fontSize: width * 0.028,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: width * 0.03,
                            vertical: width * 0.025,
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                            size: width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.02),

                  // TOMBOL TAMBAH
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TambahPesananPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: width * 0.10,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.025,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: width * 0.04,
                          ),
                          SizedBox(width: width * 0.01),
                          Text(
                            "Tambah",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.026,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: width * 0.025),

              Text(
                "Data Pesanan",
                style: TextStyle(
                  fontSize: width * 0.032,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: width * 0.02),

              // TABLE
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: width * 2.2,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: width * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffD9DDE0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              TableHeader(width: 40, title: "No."),
                              TableHeader(width: 80, title: "ID"),
                              TableHeader(width: 110, title: "Pelanggan"),
                              TableHeader(width: 90, title: "Pesanan"),
                              TableHeader(width: 90, title: "Acara"),
                              TableHeader(width: 100, title: "Alamat"),
                              TableHeader(width: 110, title: "Menu"),
                              TableHeader(width: 80, title: "Total"),
                              TableHeader(width: 60, title: "DP"),
                              TableHeader(width: 110, title: "Status"),
                            ],
                          ),
                        ),
                        SizedBox(height: width * 0.015),
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredPesanan.length,
                            itemBuilder: (context, index) {
                              final data = filteredPesanan[index];

                              final status =
                                  data["status"].toString().toLowerCase();

                              final dp = data["dp"].toString();

                              final bool isDp = dp != "-";

                              return Container(
                                margin: EdgeInsets.only(
                                  bottom: width * 0.015,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: width * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffD9DDE0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    TableCellText(
                                      width: 40,
                                      text: data["no"],
                                    ),
                                    TableCellText(
                                      width: 80,
                                      text: data["id"],
                                    ),
                                    TableCellText(
                                      width: 110,
                                      text: "${data["nama"]}\n${data["hp"]}",
                                    ),
                                    TableCellText(
                                      width: 90,
                                      text: data["tglPesanan"],
                                    ),
                                    TableCellText(
                                      width: 90,
                                      text: data["tglAcara"],
                                    ),
                                    TableCellText(
                                      width: 100,
                                      text: data["alamat"],
                                    ),
                                    TableCellText(
                                      width: 110,
                                      text: data["menu"],
                                    ),
                                    TableCellText(
                                      width: 80,
                                      text: data["total"],
                                    ),
                                    TableCellText(
                                      width: 60,
                                      text: data["dp"],
                                    ),

                                    // STATUS + LOGIKA
                                    SizedBox(
                                      width: 110,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.01,
                                              vertical: width * 0.01,
                                            ),
                                            decoration: BoxDecoration(
                                              color: data["statusColor"],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              data["status"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: width * 0.02,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: width * 0.01),

                                          // MENUNGGU KONFIRMASI
                                          if (status.contains("menunggu"))
                                            Column(
                                              children: [
                                                // ================= DETAIL BUTTON =================
                                                GestureDetector(
                                                  onTap: () async {
                                                    final result =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const VerifikasiPembayaranPage(),
                                                      ),
                                                    );

                                                    // jika tombol verifikasi ditekan
                                                    if (result == "Diproses") {
                                                      setState(() {
                                                        data["status"] =
                                                            "Diproses";
                                                        data["statusColor"] =
                                                            Colors.green;
                                                      });
                                                    }

                                                    // jika tombol tolak ditekan
                                                    else if (result ==
                                                        "Ditolak") {
                                                      setState(() {
                                                        data["status"] =
                                                            "Ditolak";
                                                        data["statusColor"] =
                                                            Colors.red;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: width * 0.04,
                                                      vertical: width * 0.015,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: const Text(
                                                      "Detail",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: width * 0.005,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      data["status"] =
                                                          "Diproses";
                                                      data["statusColor"] =
                                                          Colors.green;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Setujui",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: width * 0.022,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )

                                          // DIPROSES / DIKIRIM / SELESAI
                                          else if ((status
                                                      .contains("diproses") ||
                                                  status.contains("dikirim") ||
                                                  status.contains("selesai")) &&
                                              isDp)
                                            GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                "Detail",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.022,
                                                ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HEADER TABLE
class TableHeader extends StatelessWidget {
  final double width;
  final String title;

  const TableHeader({
    super.key,
    required this.width,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.025,
        ),
      ),
    );
  }
}

// CELL TABLE
class TableCellText extends StatelessWidget {
  final double width;
  final String text;

  const TableCellText({
    super.key,
    required this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: screenWidth * 0.022,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
