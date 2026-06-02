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
      home: const LaporanPembayaranPage(),
    );
  }
}

class LaporanPembayaranPage extends StatefulWidget {
  const LaporanPembayaranPage({Key? key}) : super(key: key);

  @override
  State<LaporanPembayaranPage> createState() => _LaporanPembayaranPageState();
}

class _LaporanPembayaranPageState extends State<LaporanPembayaranPage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> dataLaporan = [
    {
      "no": "1.",
      "id": "ORD006",
      "nama": "Yanto",
      "telp": "08212121121",
      "tgl_bayar": "15-04-2026",
      "tgl_acara": "19-04-2026",
      "jenis": "DP",
      "total": "Rp.15.500.000",
      "status": "LUNAS"
    },
    {
      "no": "2.",
      "id": "ORD007",
      "nama": "Mina",
      "telp": "08212121129",
      "tgl_bayar": "19-04-2026",
      "tgl_acara": "04-05-2026",
      "jenis": "Lunas",
      "total": "Rp.20.500.000",
      "status": "LUNAS"
    },
    {
      "no": "3.",
      "id": "ORD008",
      "nama": "Intan",
      "telp": "08212121123",
      "tgl_bayar": "25-03-2026",
      "tgl_acara": "25-04-2026",
      "jenis": "DP",
      "total": "Rp.25.000.000",
      "status": "LUNAS"
    },
    {
      "no": "4.",
      "id": "ORD009",
      "nama": "Joko",
      "telp": "08212121125",
      "tgl_bayar": "19-04-2026",
      "tgl_acara": "25-04-2026",
      "jenis": "Lunas",
      "total": "Rp.15.500.000",
      "status": "LUNAS"
    },
  ];

  List<Map<String, dynamic>> filteredData = [];

  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();

    filteredData = List.from(dataLaporan);

    searchController.addListener(() {
      filterData();
    });
  }

  // CONVERT DATE
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
      filteredData = dataLaporan.where((item) {
        final nama = item["nama"].toString().toLowerCase();

        final id = item["id"].toString().toLowerCase();

        final tglBayar = item["tgl_bayar"].toString().toLowerCase();

        final tglAcara = item["tgl_acara"].toString().toLowerCase();

        DateTime tanggalBayar = convertToDate(item["tgl_bayar"]);

        bool cocokPencarian = nama.contains(query) ||
            id.contains(query) ||
            tglBayar.contains(query) ||
            tglAcara.contains(query);

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

          cocokTanggal = tanggalBayar.isAfter(
                startDate.subtract(
                  const Duration(days: 1),
                ),
              ) &&
              tanggalBayar.isBefore(
                endDate.add(
                  const Duration(days: 1),
                ),
              );
        }

        return cocokPencarian && cocokTanggal;
      }).toList();
    });
  }

  // PILIH TANGGAL
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
              margin: const EdgeInsets.symmetric(horizontal: 8),
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
                            text: "Pemilik/Laporan Pembayaran",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  // SEARCH
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xff4b5ca8),
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari nama, id, tgl bayar, tgl acara",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black54,
                          ),
                          contentPadding: EdgeInsets.only(top: 15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // KALENDER
                  InkWell(
                    onTap: pilihTanggal,
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffd9dede),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedDateRange == null
                                ? "Pilih Tanggal"
                                : "${formatDate(selectedDateRange!.start)} - ${formatDate(selectedDateRange!.end)}",
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.keyboard_arrow_down,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // TITLE
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Laporan Pembayaran",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF1A46A1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Unduh PDF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // TABLE
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(
                        const Color(0xFFDEE5E7),
                      ),
                      dataRowMinHeight: 60,
                      dataRowMaxHeight: 70,
                      horizontalMargin: 10,
                      columnSpacing: 24,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'No.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ID Pembayaran',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nama Pelanggan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tgl. Bayar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tgl. Acara',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Jenis',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Aksi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: filteredData.map((item) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(item['no']),
                            ),
                            DataCell(
                              Text(item['id']),
                            ),
                            DataCell(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['nama'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item['telp'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(
                              Text(item['tgl_bayar']),
                            ),
                            DataCell(
                              Text(item['tgl_acara']),
                            ),
                            DataCell(
                              Text(item['jenis']),
                            ),
                            DataCell(
                              Text(item['total']),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xff6ddc4f,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  "LUNAS",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
