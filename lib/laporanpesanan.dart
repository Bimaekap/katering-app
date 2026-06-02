import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaporanPesananPage(),
    );
  }
}

class LaporanPesananPage extends StatefulWidget {
  const LaporanPesananPage({super.key});

  @override
  State<LaporanPesananPage> createState() => _LaporanPesananPageState();
}

class _LaporanPesananPageState extends State<LaporanPesananPage> {
  final TextEditingController searchController = TextEditingController();

  // DATA
  final List<Map<String, dynamic>> laporanData = [
    {
      "no": "1.",
      "id": "ORD001",
      "nama": "Budi",
      "tglPesan": "20-04-2026",
      "tglAcara": "29-05-2026",
      "alamat": "Jl.Karo",
      "status": "Selesai",
    },
    {
      "no": "2.",
      "id": "ORD002",
      "nama": "Andi",
      "tglPesan": "22-04-2026",
      "tglAcara": "30-05-2026",
      "alamat": "Jl.Medan",
      "status": "Selesai",
    },
    {
      "no": "3.",
      "id": "ORD003",
      "nama": "Sinta",
      "tglPesan": "23-04-2026",
      "tglAcara": "01-06-2026",
      "alamat": "Jl.Binjai",
      "status": "Selesai",
    },
    {
      "no": "4.",
      "id": "ORD004",
      "nama": "Rina",
      "tglPesan": "24-04-2026",
      "tglAcara": "03-06-2026",
      "alamat": "Jl.Karo",
      "status": "Selesai",
    },
    {
      "no": "5.",
      "id": "ORD005",
      "nama": "Doni",
      "tglPesan": "25-04-2026",
      "tglAcara": "05-06-2026",
      "alamat": "Jl.Setia Budi",
      "status": "Selesai",
    },
    {
      "no": "6.",
      "id": "ORD006",
      "nama": "Rudi",
      "tglPesan": "26-04-2026",
      "tglAcara": "07-06-2026",
      "alamat": "Jl.Gatot Subroto",
      "status": "Selesai",
    },
    {
      "no": "7.",
      "id": "ORD007",
      "nama": "Kevin",
      "tglPesan": "27-04-2026",
      "tglAcara": "10-06-2026",
      "alamat": "Jl.Krakatau",
      "status": "Selesai",
    },
    {
      "no": "8.",
      "id": "ORD008",
      "nama": "Maria",
      "tglPesan": "28-04-2026",
      "tglAcara": "11-06-2026",
      "alamat": "Jl.Ayahanda",
      "status": "Selesai",
    },
    {
      "no": "9.",
      "id": "ORD009",
      "nama": "Putra",
      "tglPesan": "29-04-2026",
      "tglAcara": "12-06-2026",
      "alamat": "Jl.Marelan",
      "status": "Selesai",
    },
    {
      "no": "10.",
      "id": "ORD010",
      "nama": "Rizky",
      "tglPesan": "30-04-2026",
      "tglAcara": "14-06-2026",
      "alamat": "Jl.Amplas",
      "status": "Selesai",
    },
    {
      "no": "11.",
      "id": "ORD011",
      "nama": "Citra",
      "tglPesan": "01-05-2026",
      "tglAcara": "15-06-2026",
      "alamat": "Jl.Karo",
      "status": "Selesai",
    },
  ];

  List<Map<String, dynamic>> filteredData = [];

  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();

    filteredData = List.from(laporanData);

    searchController.addListener(() {
      filterData();
    });
  }

  // CONVERT STRING KE DATETIME
  DateTime convertToDate(String date) {
    final split = date.split("-");

    return DateTime(
      int.parse(split[2]),
      int.parse(split[1]),
      int.parse(split[0]),
    );
  }

  // FILTER DATA
  void filterData() {
    String query = searchController.text.toLowerCase().trim();

    setState(() {
      filteredData = laporanData.where((item) {
        final nama = item["nama"].toString().toLowerCase();
        final id = item["id"].toString().toLowerCase();
        final tglPesan = item["tglPesan"].toString().toLowerCase();
        final tglAcara = item["tglAcara"].toString().toLowerCase();

        // DATE
        DateTime tanggalPesan = convertToDate(item["tglPesan"]);
        DateTime tanggalAcara = convertToDate(item["tglAcara"]);

        // FORMAT BULAN / TAHUN / MINGGU
        String bulanPesan = tanggalPesan.month.toString(); // contoh: 4
        String tahunPesan = tanggalPesan.year.toString(); // contoh: 2026

        int mingguPesan =
            ((tanggalPesan.day - 1) ~/ 7) + 1; // minggu ke 1,2,3,4

        // PENCARIAN
        bool cocokPencarian = nama.contains(query) ||
            id.contains(query) ||
            tglPesan.contains(query) ||
            tglAcara.contains(query) ||
            bulanPesan.contains(query) ||
            tahunPesan.contains(query) ||
            "minggu $mingguPesan".contains(query);

        // FILTER TANGGAL RANGE
        bool cocokTanggal = true;

        if (selectedDateRange != null) {
          DateTime startDate = DateTime(
            selectedDateRange!.start.year,
            selectedDateRange!.start.month,
            selectedDateRange!.start.day,
          );

          DateTime endDate = DateTime(
            selectedDateRange!.end.year,
            selectedDateRange!.end.month,
            selectedDateRange!.end.day,
            23,
            59,
            59,
          );

          cocokTanggal = tanggalPesan.isAfter(
                startDate.subtract(const Duration(days: 1)),
              ) &&
              tanggalPesan.isBefore(
                endDate.add(const Duration(days: 1)),
              );
        }

        return cocokPencarian && cocokTanggal;
      }).toList();
    });
  }

  // PILIH RANGE TANGGAL
  Future<void> pilihTanggal() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      initialDateRange: selectedDateRange,
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });

      filterData();
    }
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} "
        "${getMonth(date.month)} "
        "${date.year}";
  }

  String getMonth(int month) {
    List<String> bulan = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Jun",
      "Jul",
      "Agu",
      "Sep",
      "Okt",
      "Nov",
      "Des",
    ];

    return bulan[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // HEADER
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffd9dede),
                  // GARIS BIRU DIHILANGKAN
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        "Ridu Sianturi\nCatering",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff2342b8),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/gambar_logo.png',
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Admin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // DASHBOARD
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffd9dede),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.home_outlined),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Dasbord ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "Pemilik/Laporan Pesanan",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // SEARCH DAN FILTER
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xff4b5ca8),
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari nama, id, bulan, minggu, tahun",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.only(top: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: pilihTanggal,
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xffd9dede),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            selectedDateRange == null
                                ? "Pilih Tanggal"
                                : "${formatDate(selectedDateRange!.start)} - ${formatDate(selectedDateRange!.end)}",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 15),

              // TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Laporan Pesanan",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff2342b8),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "Unduh\nPDF",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10),

              // TABLE
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 900,
                    child: Column(
                      children: [
                        // HEADER TABLE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffd9dede),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: const [
                              HeaderCell(
                                title: "No.",
                                width: 50,
                              ),
                              HeaderCell(
                                title: "ID Pesanan",
                                width: 120,
                              ),
                              HeaderCell(
                                title: "Nama",
                                width: 120,
                              ),
                              HeaderCell(
                                title: "Tgl. Pesan",
                                width: 130,
                              ),
                              HeaderCell(
                                title: "Tgl. Acara",
                                width: 130,
                              ),
                              HeaderCell(
                                title: "Alamat",
                                width: 150,
                              ),
                              HeaderCell(
                                title: "Status",
                                width: 150,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // DATA TABLE
                        Expanded(
                          child: filteredData.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Data tidak ditemukan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: filteredData.length,
                                  itemBuilder: (context, index) {
                                    final item = filteredData[index];

                                    return Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 8,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xffd9dede,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          DataCellWidget(
                                            text: item["no"],
                                            width: 50,
                                          ),
                                          DataCellWidget(
                                            text: item["id"],
                                            width: 120,
                                            bold: true,
                                          ),
                                          DataCellWidget(
                                            text: item["nama"],
                                            width: 120,
                                            bold: true,
                                          ),
                                          DataCellWidget(
                                            text: item["tglPesan"],
                                            width: 130,
                                            bold: true,
                                          ),
                                          DataCellWidget(
                                            text: item["tglAcara"],
                                            width: 130,
                                            bold: true,
                                          ),
                                          DataCellWidget(
                                            text: item["alamat"],
                                            width: 150,
                                            bold: true,
                                          ),

                                          // STATUS
                                          SizedBox(
                                            width: 150,
                                            child: Center(
                                              child: Container(
                                                width: 90,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xff6ddc4f,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    5,
                                                  ),
                                                ),
                                                child: Text(
                                                  item["status"],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
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

                        // FOOTER
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffd9dede),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Menampilkan ${filteredData.length} data dari ${laporanData.length}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                "Selanjutnya",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// HEADER CELL
class HeaderCell extends StatelessWidget {
  final String title;
  final double width;

  const HeaderCell({
    super.key,
    required this.title,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 14,
        ),
      ),
    );
  }
}

// DATA CELL
class DataCellWidget extends StatelessWidget {
  final String text;
  final double width;
  final bool bold;

  const DataCellWidget({
    super.key,
    required this.text,
    required this.width,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
