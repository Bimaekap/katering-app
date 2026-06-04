import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transfer_page.dart';
import 'ewallet_page.dart';

class PaymentPage extends StatefulWidget {
  final int totalHarga;
  // ======= PARAMETER BARU DARI KERANJANG =======
  final String pesananId;
  final String namaCustomer;
  final String nomorHp;

  const PaymentPage({
    super.key,
    required this.totalHarga,
    required this.pesananId,
    required this.namaCustomer,
    required this.nomorHp,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late int minimalDp;

  String selectedPayment = "dp";
  String selectedMethod = "";

  final TextEditingController dpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // DP 30%
    minimalDp = (widget.totalHarga * 0.3).toInt();

    // otomatis isi nominal DP
    dpController.text = minimalDp.toString();
  }

  String formatRupiah(int number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff9BAEB3),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 15,
                    top: 25,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Pembayaran",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // TOTAL PEMBAYARAN
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xffB8C7CC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // TOTAL HARGA
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xffB8C7CC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  formatRupiah(widget.totalHarga),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // PILIH PEMBAYARAN
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pilih pembayaran:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // DP
            paymentOption(
              title: "DP minimal: ${formatRupiah(minimalDp)}",
              value: "dp",
            ),

            // INPUT DP
            if (selectedPayment == "dp")
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jumlah uang muka",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: dpController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Masukkan nominal DP",
                        prefixText: "Rp. ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Minimal DP ${formatRupiah(minimalDp)}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

            // LUNAS
            paymentOption(
              title: "Lunas ${formatRupiah(widget.totalHarga)}",
              value: "full",
            ),

            const SizedBox(height: 15),

            // METODE PEMBAYARAN
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Metode Pembayaran:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // PILIH METODE
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffF2DDCF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: paymentMethod(
                      title: "Transfer",
                      icon: Icons.account_balance,
                      value: "bank",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: paymentMethod(
                      title: "E-Wallet",
                      icon: Icons.account_balance_wallet_outlined,
                      value: "ewallet",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TOMBOL KONFIRMASI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Hitung nominal yang akan dibayar
                    final int nominalBayar = selectedPayment == 'dp'
                        ? int.tryParse(dpController.text) ?? minimalDp
                        : widget.totalHarga;

                    // KE HALAMAN TRANSFER
                    if (selectedMethod == "bank") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransferBankPage(
                            pesananId: widget.pesananId,
                            namaCustomer: widget.namaCustomer,
                            nomorHp: widget.nomorHp,
                            jenisPembayaran: selectedPayment,
                            nominal: nominalBayar,
                          ),
                        ),
                      );
                    } else if (selectedMethod == "ewallet") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EwalletPage(
                            pesananId: widget.pesananId,
                            namaCustomer: widget.namaCustomer,
                            nomorHp: widget.nomorHp,
                            jenisPembayaran: selectedPayment,
                            nominal: nominalBayar,
                          ),
                        ),
                      );
                    }

                    // BELUM PILIH METODE
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Pilih metode pembayaran terlebih dahulu",
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Konfirmasi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  // WIDGET PILIH PEMBAYARAN
  Widget paymentOption({
    required String title,
    required String value,
  }) {
    bool selected = selectedPayment == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 6,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffB8C7CC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black54),
                color: selected ? Colors.green : Colors.white,
              ),
              child: selected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET METODE PEMBAYARAN
  Widget paymentMethod({
    required String title,
    required IconData icon,
    required String value,
  }) {
    bool selected = selectedMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffB8C7CC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? Colors.green : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
