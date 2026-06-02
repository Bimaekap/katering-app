import 'package:flutter/material.dart';
import 'package:flutter_application_1/pembatalan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailPesananPage(),
    );
  }
}

class DetailPesananPage extends StatefulWidget {
  const DetailPesananPage({super.key});

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  final TextEditingController alasanController = TextEditingController();

  @override
  void dispose() {
    alasanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFF74D63E),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Detail Pesanan",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 42),
                ],
              ),

              const SizedBox(height: 10),
              const Text(
                "Informasi Pemesan",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFC9D4D8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    buildInfoRow("Dyren", "Jl. Mahoni"),
                    buildInfoRow("Status", "Sedang Diproses"),
                    buildInfoRow("Tgl Pesanan", "19 April 2026"),
                    buildInfoRow("Tgl Acara", "05 Mei 2026"),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              buildMenuCard(
                image: "assets/babi_saksang.png",
                title: "Saksang",
                description:
                    "Saksang dengan nasi, sayur acar, pisang, sop, kopi.",
                qty: "100",
              ),

              const SizedBox(height: 8),

              buildMenuCard(
                image: "assets/ayam_napinadar.png",
                title: "Ayam Napinadar",
                description:
                    "Ayam napinadar dengan nasi, buncis, telur, tahu tempe.",
                qty: "50",
              ),

              const SizedBox(height: 8),

              Divider(
                color: Colors.black.withOpacity(0.6),
              ),

              const SizedBox(height: 4),

              buildPriceRow("TOTAL", "Rp. 5.250.000"),
              buildPriceRow("DP", "Rp. 1.675.000"),
              buildPriceRow("Sisa", "Rp. 3.575.000"),

              const SizedBox(height: 8),

              const Text(
                "Alasan Pembatalan:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 4),

              Container(
                height: 60, // DIPERKECIL
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EDF3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                ),
                child: TextField(
                  controller: alasanController,
                  maxLength: 150,
                  maxLines: 2, // DIPERKECIL
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    hintText: "Masukkan alasan pembatalan...",
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 11,
                    ),
                    border: InputBorder.none,
                    counterText: "",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 2),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${alasanController.text.length}/150 karakter",
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),

              const SizedBox(height: 3),

              const Text(
                "Catatan: Uang muka tidak akan dikembalikan apabila pembatalan melewati H-3 pengerjaan pesanan.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 9,
                ),
              ),

              const Spacer(),

              // ================= BUTTON =================
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (alasanController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Alasan pembatalan wajib diisi",
                          ),
                        ),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.warning_rounded,
                                color: Colors.red,
                                size: 60,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "Batalkan Pesanan",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Anda yakin ingin membatalkan pesanan ini?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  // TIDAK
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                      ),
                                      child: const Text(
                                        "Tidak",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),
                                  // YA
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Pembatalan berhasil dikirim\nAlasan: ${alasanController.text}",
                                            ),
                                          ),
                                        );

                                        // NAVIGATOR KE HALAMAN PEMBATALAN DIPROSES
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PembatalanDiprosesPage(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text(
                                        "Ya",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 210,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2444D8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        "Konfirmasi Pembatalan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INFO ROW =================
  static Widget buildInfoRow(
    String left,
    String right,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 1,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              left,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          Text(
            right,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ================= MENU CARD =================
  static Widget buildMenuCard({
    required String image,
    required String title,
    required String description,
    required String qty,
  }) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: const Color(0xFFC9D4D8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 68,
              height: 68,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 8),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 9,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                const Text(
                  "Rp. 35.000",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          // QTY
          Container(
            width: 60,
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xFF74D63E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "-",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  qty,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "+",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= PRICE ROW =================
  static Widget buildPriceRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
