import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sans-Serif',
      ),
      home: const LaporanKeuanganPage(),
    );
  }
}

class LaporanKeuanganPage extends StatefulWidget {
  const LaporanKeuanganPage({Key? key}) : super(key: key);

  @override
  State<LaporanKeuanganPage> createState() => _LaporanKeuanganPageState();
}

class _LaporanKeuanganPageState extends State<LaporanKeuanganPage> {
  final TextEditingController searchController = TextEditingController();

  DateTimeRange? selectedDateRange;

  final List<Map<String, dynamic>> dataKeuangan = [
    {
      "no": "1.",
      "tanggal": "10-04-2026",
      "keterangan": "Pembayaran Pesanan\nORD006",
      "kategori": "Pemasukan",
      "pemasukan": "Rp.20.000.000",
      "pengeluaran": "-",
      "saldo": "Rp.20.000.000",
      "is_pemasukan": true
    },
    {
      "no": "2.",
      "tanggal": "11-04-2026",
      "keterangan": "Pengembalian Dana\nORD000",
      "kategori": "Pengeluaran",
      "pemasukan": "-",
      "pengeluaran": "Rp.2.000.000",
      "saldo": "-Rp.2.000.000",
      "is_pemasukan": false
    },
    {
      "no": "3.",
      "tanggal": "12-04-2026",
      "keterangan": "Pembayaran Pesanan\nORD008",
      "kategori": "Pemasukan",
      "pemasukan": "Rp.5.000.000",
      "pengeluaran": "-",
      "saldo": "Rp.5.000.000",
      "is_pemasukan": true
    },
  ];

  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();

    filteredData = List.from(dataKeuangan);

    searchController.addListener(() {
      filterData();
    });
  }

  DateTime convertToDate(String date) {
    final split = date.split("-");

    return DateTime(
      int.parse(split[2]),
      int.parse(split[1]),
      int.parse(split[0]),
    );
  }

  void filterData() {
    String query = searchController.text.toLowerCase().trim();

    setState(() {
      filteredData = dataKeuangan.where((item) {
        final tanggal = item["tanggal"].toString().toLowerCase();

        final kategori = item["kategori"].toString().toLowerCase();

        final keterangan = item["keterangan"].toString().toLowerCase();

        DateTime tanggalData = convertToDate(item["tanggal"]);

        bool cocokPencarian = tanggal.contains(query) ||
            kategori.contains(query) ||
            keterangan.contains(query);

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

          cocokTanggal = tanggalData.isAfter(
                startDate.subtract(
                  const Duration(days: 1),
                ),
              ) &&
              tanggalData.isBefore(
                endDate.add(
                  const Duration(days: 1),
                ),
              );
        }

        return cocokPencarian && cocokTanggal;
      }).toList();
    });
  }

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
                              text: "Pemilik/Laporan Keuangan",
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
                          hintText: "Cari tanggal, kategori, keterangan",
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffd9dede),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 18,
                          ),
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
                          const Icon(
                            Icons.keyboard_arrow_down,
                          ),
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
                    "Laporan Keuangan",
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
                    width: 1100,
                    child: Column(
                      children: [
                        // HEADER TABLE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffd9dede),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Row(
                            children: const [
                              HeaderCell(
                                title: "No.",
                                width: 50,
                              ),
                              HeaderCell(
                                title: "Tanggal",
                                width: 120,
                              ),
                              HeaderCell(
                                title: "Keterangan",
                                width: 180,
                              ),
                              HeaderCell(
                                title: "Kategori",
                                width: 120,
                              ),
                              HeaderCell(
                                title: "Pemasukan",
                                width: 150,
                              ),
                              HeaderCell(
                                title: "Pengeluaran",
                                width: 150,
                              ),
                              HeaderCell(
                                title: "Saldo",
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

                                    Color saldoColor = item['is_pemasukan']
                                        ? const Color(0xFF4CB050)
                                        : const Color(0xFFD33A3A);

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
                                            text: item["tanggal"],
                                            width: 120,
                                            bold: true,
                                          ),

                                          // KETERANGAN
                                          SizedBox(
                                            width: 180,
                                            child: Text(
                                              item["keterangan"],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                height: 1.4,
                                              ),
                                            ),
                                          ),

                                          DataCellWidget(
                                            text: item["kategori"],
                                            width: 120,
                                            bold: true,
                                          ),

                                          // PEMASUKAN
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              item["pemasukan"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: item["pemasukan"] != "-"
                                                    ? const Color(0xFF4CB050)
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),

                                          // PENGELUARAN
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              item["pengeluaran"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: item["pengeluaran"] !=
                                                        "-"
                                                    ? const Color(0xFFD33A3A)
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),

                                          // SALDO
                                          SizedBox(
                                            width: 150,
                                            child: Text(
                                              item["saldo"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: saldoColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),

                        // TOTAL
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffd9dede),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Row(
                            children: const [
                              SizedBox(width: 50),
                              SizedBox(width: 120),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  "Total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 120),
                              SizedBox(width: 150),
                              SizedBox(width: 150),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  "Rp.23.000.000",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(
                                      0xFF4CB050,
                                    ),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // FOOTER
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffd9dede),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Menampilkan ${filteredData.length} data dari ${dataKeuangan.length}",
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
