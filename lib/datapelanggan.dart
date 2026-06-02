import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const KelolaPelangganPage(),
    );
  }
}

class KelolaPelangganPage extends StatefulWidget {
  const KelolaPelangganPage({super.key});

  @override
  State<KelolaPelangganPage> createState() => _KelolaPelangganPageState();
}

class _KelolaPelangganPageState extends State<KelolaPelangganPage> {
  final TextEditingController searchController = TextEditingController();

  late List<Map<String, String>> pelanggan;
  late List<Map<String, String>> filteredPelanggan;

  @override
  void initState() {
    super.initState();

    pelanggan = [
      {
        "no": "1.",
        "nama": "Dyren",
        "telp": "081212120034",
        "email": "dyren@gmail.com",
        "alamat": "Jl. sm raja"
      },
      {
        "no": "2.",
        "nama": "Rani",
        "telp": "081212120039",
        "email": "rani@gmail.com",
        "alamat": "Jl. sm raja"
      },
      {
        "no": "3.",
        "nama": "Luna",
        "telp": "081212120038",
        "email": "luna@gmail.com",
        "alamat": "Jl. madu.17"
      },
      {
        "no": "4.",
        "nama": "Maya",
        "telp": "081212120037",
        "email": "maya@gmail.com",
        "alamat": "Jl.hakikat no.11"
      },
      {
        "no": "5.",
        "nama": "Luke",
        "telp": "081212120036",
        "email": "luke@gmail.com",
        "alamat": "Jl.hakikat no.11"
      },
      {
        "no": "6.",
        "nama": "Asni",
        "telp": "081212120035",
        "email": "asni@gmail.com",
        "alamat": "Jl.hakikat no.11"
      },
      {
        "no": "7.",
        "nama": "Piten",
        "telp": "081212120032",
        "email": "piten@gmail.com",
        "alamat": "Jl.hakikat no.11"
      },
      {
        "no": "8.",
        "nama": "Andi",
        "telp": "081234567801",
        "email": "andi@gmail.com",
        "alamat": "Jl. Mawar No.1"
      },
      {
        "no": "9.",
        "nama": "Budi",
        "telp": "081234567802",
        "email": "budi@gmail.com",
        "alamat": "Jl. Melati No.2"
      },
      {
        "no": "10.",
        "nama": "Citra",
        "telp": "081234567803",
        "email": "citra@gmail.com",
        "alamat": "Jl. Kenanga No.3"
      },
      {
        "no": "11.",
        "nama": "Dewi",
        "telp": "081234567804",
        "email": "dewi@gmail.com",
        "alamat": "Jl. Flamboyan"
      },
      {
        "no": "12.",
        "nama": "Eko",
        "telp": "081234567805",
        "email": "eko@gmail.com",
        "alamat": "Jl. Sakura"
      },
      {
        "no": "13.",
        "nama": "Farah",
        "telp": "081234567806",
        "email": "farah@gmail.com",
        "alamat": "Jl. Anggrek"
      },
      {
        "no": "14.",
        "nama": "Gilang",
        "telp": "081234567807",
        "email": "gilang@gmail.com",
        "alamat": "Jl. Rajawali"
      },
      {
        "no": "15.",
        "nama": "Hani",
        "telp": "081234567808",
        "email": "hani@gmail.com",
        "alamat": "Jl. Cemara"
      },
      {
        "no": "16.",
        "nama": "Indra",
        "telp": "081234567809",
        "email": "indra@gmail.com",
        "alamat": "Jl. Nusa Indah"
      },
      {
        "no": "17.",
        "nama": "Jeni",
        "telp": "081234567810",
        "email": "jeni@gmail.com",
        "alamat": "Jl. Dahlia"
      },
      {
        "no": "18.",
        "nama": "Kevin",
        "telp": "081234567811",
        "email": "kevin@gmail.com",
        "alamat": "Jl. Kamboja"
      },
      {
        "no": "19.",
        "nama": "Lina",
        "telp": "081234567812",
        "email": "lina@gmail.com",
        "alamat": "Jl. Merpati"
      },
      {
        "no": "20.",
        "nama": "Mira",
        "telp": "081234567813",
        "email": "mira@gmail.com",
        "alamat": "Jl. Elang"
      },
      {
        "no": "21.",
        "nama": "Nanda",
        "telp": "081234567814",
        "email": "nanda@gmail.com",
        "alamat": "Jl. Cendrawasih"
      },
      {
        "no": "22.",
        "nama": "Oscar",
        "telp": "081234567815",
        "email": "oscar@gmail.com",
        "alamat": "Jl. Kenari"
      },
      {
        "no": "23.",
        "nama": "Putri",
        "telp": "081234567816",
        "email": "putri@gmail.com",
        "alamat": "Jl. Bougenville"
      },
      {
        "no": "24.",
        "nama": "Qori",
        "telp": "081234567817",
        "email": "qori@gmail.com",
        "alamat": "Jl. Veteran"
      },
      {
        "no": "25.",
        "nama": "Riko",
        "telp": "081234567818",
        "email": "riko@gmail.com",
        "alamat": "Jl. Merdeka"
      },
      {
        "no": "26.",
        "nama": "Salsa",
        "telp": "081234567819",
        "email": "salsa@gmail.com",
        "alamat": "Jl. Diponegoro"
      },
      {
        "no": "27.",
        "nama": "Tono",
        "telp": "081234567820",
        "email": "tono@gmail.com",
        "alamat": "Jl. Sudirman"
      },
    ];

    filteredPelanggan = List.from(pelanggan);
  }

  // ================= FUNGSI SEARCH =================
  void searchPelanggan(String keyword) {
    setState(() {
      filteredPelanggan = pelanggan.where((item) {
        final input = keyword.toLowerCase();

        return item["nama"]!.toLowerCase().contains(input) ||
            item["telp"]!.toLowerCase().contains(input) ||
            item["email"]!.toLowerCase().contains(input) ||
            item["alamat"]!.toLowerCase().contains(input);
      }).toList();
    });
  }

  // ================= FUNGSI DELETE =================
  void deletePelanggan(Map<String, String> item) {
    setState(() {
      pelanggan.remove(item);
      filteredPelanggan.remove(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${item["nama"]} berhasil dihapus",
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
                  color: const Color(0xffD7E0E5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // ================= TOMBOL KEMBALI =================
                    InkWell(
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
                          color: Color(0xff2447C6),
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= DASHBOARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffD7E0E5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.home_outlined,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Dashboard Admin / Mengelola Pelanggan",
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

              // ================= SEARCH =================
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff2447C6),
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
                          searchPelanggan(value);
                        },
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari nama, nomor, email, alamat",
                          hintStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
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

              const SizedBox(height: 10),

              // ================= TITLE =================
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Data Pelanggan",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // ================= TABLE DATA =================
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 700,
                      child: SingleChildScrollView(
                        child: Column(
                          children: filteredPelanggan.map((item) {
                            return Container(
                              margin: const EdgeInsets.only(
                                bottom: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffE2E5E8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Text(
                                      item["no"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                      item["nama"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      item["telp"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 160,
                                    child: Text(
                                      item["email"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 140,
                                    child: Text(
                                      item["alamat"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),

                                  const Icon(
                                    Icons.edit,
                                    color: Colors.indigo,
                                    size: 18,
                                  ),

                                  const SizedBox(width: 10),

                                  // ================= DELETE =================
                                  GestureDetector(
                                    onTap: () {
                                      deletePelanggan(item);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ================= FOOTER =================
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffE2E5E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Menampilkan ${filteredPelanggan.length} data",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
