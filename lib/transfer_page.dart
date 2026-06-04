import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_service.dart';
import 'package:flutter_application_1/success_page.dart';
import 'package:image_picker/image_picker.dart';

class TransferBankPage extends StatefulWidget {
  final String pesananId;
  final String namaCustomer;
  final String nomorHp;
  final String jenisPembayaran;
  final int nominal;
  final String bankDipilih;

  const TransferBankPage({
    super.key,
    required this.pesananId,
    required this.namaCustomer,
    required this.nomorHp,
    required this.jenisPembayaran,
    required this.nominal,
    this.bankDipilih = '',
  });

  @override
  State<TransferBankPage> createState() => _TransferBankPageState();
}

class _TransferBankPageState extends State<TransferBankPage> {
  XFile? _pickedFile;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? file =
        await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1200);
    if (file != null) setState(() => _pickedFile = file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              height: 110,
              width: double.infinity,
              color: const Color(0xFFD3DEE0),
              child: Stack(
                children: [
                  Positioned(
                    top: 28,
                    left: 20,
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 28),
                      child: Text("Transfer Bank",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text("Pilih pembayaran:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    paymentCard(
                        image: "assets/Bank_BCA.png",
                        title: "Bank Central Asia (BCA)",
                        numberTitle: "Nomor Rekening"),
                    paymentCard(
                        image: "assets/Bank_BRI.png",
                        title: "Bank Rakyat Indonesia (BRI)",
                        numberTitle: "Nomor Rekening"),
                    paymentCard(
                        image: "assets/Bank_MANDIRI.png",
                        title: "Bank Mandiri",
                        numberTitle: "Nomor Rekening"),
                    const SizedBox(height: 10),
                    const Text("Upload Bukti Pembayaran:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    // ===== UPLOAD BOX =====
                    GestureDetector(
                      onTap: _isUploading ? null : _pickImage,
                      child: Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _pickedFile != null
                              ? Colors.green.shade50
                              : const Color(0xFFB8BBB4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _pickedFile != null
                                ? Colors.green
                                : const Color(0xFFF5D6C6),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Icon(
                                _pickedFile != null
                                    ? Icons.check_circle_outline
                                    : Icons.cloud_upload_outlined,
                                size: 45,
                                color: _pickedFile != null
                                    ? Colors.green
                                    : const Color(0xFF123DDB),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _pickedFile != null
                                  ? '✅ ${_pickedFile!.name}'
                                  : "Ketuk untuk Unggah Bukti Pembayaran",
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            if (_pickedFile == null)
                              const Text("JPG, PNG, max 10 mb",
                                  style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // ===== BUTTON KONFIRMASI =====
                    Center(
                      child: GestureDetector(
                        onTap: _isUploading
                            ? null
                            : () async {
                                if (_pickedFile == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Harap unggah bukti pembayaran terlebih dahulu')),
                                  );
                                  return;
                                }
                                setState(() => _isUploading = true);
                                try {
                                  final bytes =
                                      await _pickedFile!.readAsBytes();
                                  final ext = _pickedFile!.name
                                      .split('.')
                                      .last
                                      .toLowerCase();
                                  final contentType =
                                      ext == 'png' ? 'image/png' : 'image/jpeg';
                                  final url = await FirebaseService
                                      .uploadBuktiPembayaranFromBytes(
                                    widget.pesananId,
                                    bytes,
                                    contentType: contentType,
                                  );
                                  await FirebaseService.simpanPembayaran(
                                    pesananId: widget.pesananId,
                                    namaCustomer: widget.namaCustomer,
                                    nomorHp: widget.nomorHp,
                                    jenisPembayaran: widget.jenisPembayaran,
                                    nominal: widget.nominal,
                                    metodePembayaran: 'transfer',
                                    bankEwallet: widget.bankDipilih,
                                    buktiBayarUrl: url ?? '',
                                  );
                                  if (context.mounted) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const SuccessPage()),
                                      (route) => route.isFirst,
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Gagal: ${e.toString()}')),
                                    );
                                  }
                                } finally {
                                  if (mounted) {
                                    setState(() => _isUploading = false);
                                  }
                                }
                              },
                        child: Container(
                          height: 50,
                          width: 280,
                          decoration: BoxDecoration(
                            color: _isUploading
                                ? Colors.grey
                                : const Color(0xFF123DDB),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: _isUploading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2))
                                : const Text(
                                    "Konfirmasi Pembayaran",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentCard({
    required String image,
    required String title,
    required String numberTitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE4E8E8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Nama Pemilik", style: TextStyle(fontSize: 12)),
                    Text(numberTitle, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 3),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("Ridu Sianturi Catering",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 10),
                    Text("1234 xxxx xxxx",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.copy, size: 24, color: Colors.black54),
        ],
      ),
    );
  }
}
