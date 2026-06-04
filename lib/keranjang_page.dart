import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_service.dart';
import 'package:flutter_application_1/payment_page.dart';
import 'package:intl/intl.dart';

class KeranjangPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartList;

  const KeranjangPage({
    super.key,
    required this.cartList,
  });

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  final TextEditingController namaController = TextEditingController();

  final TextEditingController nomorController = TextEditingController();

  final TextEditingController alamatController = TextEditingController();

  final TextEditingController catatanController = TextEditingController();

  String tanggalPemesanan = "Pilih tanggal";

  String tanggalAcara = "Pilih tanggal";

  // =========================
  // TOTAL HARGA
  // =========================
  int totalHarga() {
    int total = 0;

    for (var item in widget.cartList) {
      total += int.parse(
            item['price'].toString(),
          ) *
          int.parse(
            item['qty'].toString(),
          );
    }

    return total;
  }

  // =========================
  // TOTAL PORSI
  // =========================
  int totalPorsi() {
    int total = 0;

    for (var item in widget.cartList) {
      total += int.parse(
        item['qty'].toString(),
      );
    }

    return total;
  }

  // =========================
  // POPUP PEMBAYARAN
  // =========================
  void showPaymentPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(
            20,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF243DBD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                30,
              ),
              topRight: Radius.circular(
                30,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // GARIS ATAS
                Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // LIST MENU
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.cartList.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final item = widget.cartList[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${item['qty']} Porsi",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(
                  height: 10,
                ),

                // TOTAL PESANAN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Pesanan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${totalPorsi()} Porsi",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                // TOTAL HARGA
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Harga",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rp. ${NumberFormat.decimalPattern('id').format(totalHarga())}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 35,
                ),

                // BUTTON BAYAR
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      // ======= VALIDASI FORM =======
                      if (namaController.text.trim().isEmpty ||
                          nomorController.text.trim().isEmpty ||
                          alamatController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Nama, nomor HP, dan alamat wajib diisi')),
                        );
                        return;
                      }
                      if (tanggalPemesanan == "Pilih tanggal" ||
                          tanggalAcara == "Pilih tanggal") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Tanggal pemesanan dan acara wajib dipilih')),
                        );
                        return;
                      }

                      // ======= SIMPAN PESANAN KE FIRESTORE =======
                      // Membuat dokumen baru di koleksi "pesanan"
                      final items = widget.cartList
                          .map((item) => {
                                'menuId': item['id'] ?? '',
                                'namaMenu': item['title'],
                                'harga': item['price'],
                                'qty': item['qty'],
                              })
                          .toList();

                      final pesananId = await FirebaseService.simpanPesanan(
                        namaCustomer: namaController.text.trim(),
                        nomorHp: nomorController.text.trim(),
                        alamat: alamatController.text.trim(),
                        catatan: catatanController.text.trim(),
                        tanggalPemesanan: tanggalPemesanan,
                        tanggalAcara: tanggalAcara,
                        items: items,
                        totalHarga: totalHarga(),
                        totalPorsi: totalPorsi(),
                      );

                      if (!context.mounted) return;

                      if (pesananId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Gagal menyimpan pesanan. Coba lagi.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Tutup bottom sheet lalu ke PaymentPage
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            totalHarga: totalHarga(),
                            pesananId: pesananId,
                            namaCustomer: namaController.text.trim(),
                            nomorHp: nomorController.text.trim(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          35,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Bayar Sekarang",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pilihTanggal(
    bool isPemesanan,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        String tanggal =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

        if (isPemesanan) {
          tanggalPemesanan = tanggal;
        } else {
          tanggalAcara = tanggal;
        }
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: widget.cartList.isEmpty

            // =========================
            // KERANJANG KOSONG
            // =========================
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 90,
                      color: Colors.grey,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    const Text(
                      "Keranjang kosong",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      "Silakan pilih menu terlebih dahulu",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // ================= BUTTON KEMBALI =================
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7ED436),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Kembali",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )

            // =========================
            // ADA ISI KERANJANG
            // =========================
            : Padding(
                padding: const EdgeInsets.all(
                  10,
                ),
                child: Column(
                  children: [
                    // HEADER
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(
                              0xFF7ED436,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              "Keranjang",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // LIST MENU
                    SizedBox(
                      height: 170,
                      child: ListView.builder(
                        itemCount: widget.cartList.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          final item = widget.cartList[index];

                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            padding: const EdgeInsets.all(
                              8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFD7E0E5,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  child: Image.asset(
                                    item['image'],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Qty : ${item['qty']}",
                                        style: const TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Rp. ${NumberFormat.decimalPattern('id').format(item['price'])}",
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
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

                    const SizedBox(
                      height: 8,
                    ),

                    // TOTAL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "TOTAL",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp. ${NumberFormat.decimalPattern('id').format(totalHarga())}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // DETAIL PESANAN
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFCFCFCF,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Detail Pesanan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: buildDateField(
                                    title: "Tgl Pesan",
                                    value: tanggalPemesanan,
                                    onTap: () {
                                      pilihTanggal(
                                        true,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: buildDateField(
                                    title: "Tgl Acara",
                                    value: tanggalAcara,
                                    onTap: () {
                                      pilihTanggal(
                                        false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildInputField(
                              title: "Nama",
                              hint: "Masukkan nama",
                              controller: namaController,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildInputField(
                              title: "Telepon",
                              hint: "Masukkan nomor",
                              controller: nomorController,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildInputField(
                              title: "Alamat",
                              hint: "Masukkan alamat",
                              controller: alamatController,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            buildInputField(
                              title: "Catatan",
                              hint: "Catatan tambahan",
                              controller: catatanController,
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  showPaymentPopup();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFF7ED436,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Pesan Sekarang",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildDateField({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 14,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInputField({
    required String title,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 11,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 11,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
