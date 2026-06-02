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
      home: const LaporanPiutangPage(),
    );
  }
}

class LaporanPiutangPage extends StatefulWidget {
  const LaporanPiutangPage({Key? key}) : super(key: key);

  @override
  State<LaporanPiutangPage> createState() => _LaporanPiutangPageState();
}

class _LaporanPiutangPageState extends State<LaporanPiutangPage> {
  final TextEditingController searchController = TextEditingController();

  // DATA
  final List<Map<String, dynamic>> dataPiutang = [
    {
      "no": "1.",
      "id": "ORD006",
      "nama": "Marlina",
      "telp": "08212121121",
      "tgl_pesan": "07-04-2026",
      "tgl_acara": "14-04-2026",
      "sisa_piutang": "Rp.1.000.000",
      "status": "Akan jatuh\ntempo",
      "is_warning": true
    },
    {
      "no": "2.",
      "id": "ORD007",
      "nama": "Mina",
      "telp": "08212121129",
      "tgl_pesan": "10-04-2026",
      "tgl_acara": "18-04-2026",
      "sisa_piutang": "Rp.2.500.000",
      "status": "Terlambat\n4 Hari",
      "is_warning": false
    },
    {
      "no": "3.",
      "id": "ORD008",
      "nama": "Intan",
      "telp": "08212121123",
      "tgl_pesan": "11-03-2026",
      "tgl_acara": "19-04-2026",
      "sisa_piutang": "Rp.5.000.000",
      "status": "Terlambat\n3 Hari",
      "is_warning": false
    },
    {
      "no": "4.",
      "id": "ORD009",
      "nama": "Joko",
      "telp": "08212121125",
      "tgl_pesan": "12-04-2026",
      "tgl_acara": "20-04-2026",
      "sisa_piutang": "Rp.3.000.000",
      "status": "Terlambat\n2 Hari",
      "is_warning": false
    },
  ];

  List<Map<String, dynamic>> filteredData = [];

  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();

    filteredData = List.from(dataPiutang);

    searchController.addListener(() {
      filterData();
    });
  }

  // CONVERT STRING TO DATE
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
      filteredData = dataPiutang.where((item) {
        final nama = item["nama"].toString().toLowerCase();
        final id = item["id"].toString().toLowerCase();
        final tglPesan = item["tgl_pesan"].toString().toLowerCase();
        final tglAcara = item["tgl_acara"].toString().toLowerCase();

        DateTime tanggalPesan = convertToDate(item["tgl_pesan"]);

        bool cocokPencarian = nama.contains(query) ||
            id.contains(query) ||
            tglPesan.contains(query) ||
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
                            text: "Pemilik/Laporan Piutang",
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
                          hintText: "Cari nama, id, tgl pesan, tgl acara",
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.keyboard_arrow_down),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Laporan Piutang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A46A1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
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

            const SizedBox(height: 12),

            // TABLE
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(
                        const Color(0xFFDEE5E7),
                      ),
                      dataRowMaxHeight: 75,
                      dataRowMinHeight: 65,
                      horizontalMargin: 10,
                      columnSpacing: 20,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'No.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ID Pesanan',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Nama Pelanggan',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tgl. Pesan',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tgl. Acara',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Sisa Piutang',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: filteredData.map((item) {
                        Color badgeColor = item['is_warning']
                            ? const Color(0xFFFFAE1D)
                            : const Color(0xFFD33A3A);

                        return DataRow(
                          cells: [
                            DataCell(Text(item['no'])),
                            DataCell(Text(item['id'])),
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
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(Text(item['tgl_pesan'])),
                            DataCell(Text(item['tgl_acara'])),
                            DataCell(Text(item['sisa_piutang'])),
                            DataCell(
                              Container(
                                width: 130,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: badgeColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item['status'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
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

            // FOOTER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menampilkan ${filteredData.length} data dari ${dataPiutang.length}',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Selanjutnya',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
