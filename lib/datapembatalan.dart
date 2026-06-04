import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';

class KelolaPembatalanPage extends StatefulWidget {
  const KelolaPembatalanPage({super.key});

  @override
  State<KelolaPembatalanPage> createState() => _KelolaPembatalanPageState();
}

class _KelolaPembatalanPageState extends State<KelolaPembatalanPage> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController horizontalController = ScrollController();
  String searchQuery = '';

  @override
  void dispose() {
    horizontalController.dispose();
    searchController.dispose();
    super.dispose();
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(color: const Color(0xffD9E1E5), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black54),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text("Ridu Sianturi\nCatering",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff2144D0))),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 38, width: 38,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("assets/gambar_logo.png", fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported, size: 18, color: Colors.grey)),
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text("Admin", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(color: const Color(0xffD9E1E5), borderRadius: BorderRadius.circular(10)),
                child: const Text("Admin / Mengelola Pembatalan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ),

              const SizedBox(height: 10),

              // ================= SEARCH =================
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff2144D0), width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (v) => setState(() => searchQuery = v),
                        style: const TextStyle(fontSize: 11),
                        decoration: const InputDecoration(border: InputBorder.none, hintText: "Cari Nama/ID"),
                      ),
                    ),
                    const Icon(Icons.search, size: 18),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= TABLE (FIRESTORE REALTIME) =================
              Expanded(
                child: Scrollbar(
                  controller: horizontalController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 760,
                      child: Column(
                        children: [
                          // HEADER TABLE
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(color: const Color(0xffD9E1E5), borderRadius: BorderRadius.circular(10)),
                            child: const Row(
                              children: [
                                _TableHeader(title: "No", width: 40),
                                _TableHeader(title: "ID", width: 70),
                                _TableHeader(title: "Pelanggan", width: 120),
                                _TableHeader(title: "Tanggal", width: 90),
                                _TableHeader(title: "Alasan", width: 180),
                                _TableHeader(title: "Status", width: 100),
                                _TableHeader(title: "Aksi", width: 160),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // DATA TABLE
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseService.streamSemuaPembatalan(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return const Center(child: Text('Belum ada data pembatalan'));
                                }

                                final docs = snapshot.data!.docs.where((doc) {
                                  final d = doc.data() as Map<String, dynamic>;
                                  final q = searchQuery.toLowerCase();
                                  return q.isEmpty ||
                                      (d['namaCustomer'] ?? '').toString().toLowerCase().contains(q) ||
                                      (d['pesananId'] ?? '').toString().toLowerCase().contains(q);
                                }).toList();

                                return ListView.builder(
                                  itemCount: docs.length,
                                  itemBuilder: (context, index) {
                                    final doc = docs[index];
                                    final item = doc.data() as Map<String, dynamic>;
                                    final status = item['status'] ?? 'pending';
                                    Color statusColor = status == 'pending'
                                        ? Colors.orange
                                        : status == 'disetujui'
                                            ? Colors.green
                                            : Colors.red;

                                    final tanggal = item['tanggalPembatalan'] != null
                                        ? (item['tanggalPembatalan'] as Timestamp).toDate().toString().substring(0, 10)
                                        : '-';

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffEEF2F5),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          _TableCell(text: '${index + 1}.', width: 40),
                                          _TableCell(text: (item['pesananId'] ?? '').toString().substring(0, 6).toUpperCase(), width: 70),
                                          _TableCell(text: '${item['namaCustomer'] ?? ''}\n${item['nomorHp'] ?? ''}', width: 120),
                                          _TableCell(text: tanggal, width: 90),
                                          _TableCell(text: item['alasanPembatalan'] ?? '-', width: 180),
                                          // STATUS
                                          SizedBox(
                                            width: 100,
                                            child: Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(6)),
                                                child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                          // AKSI
                                          SizedBox(
                                            width: 160,
                                            child: status == 'pending'
                                                ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await FirebaseService.updateStatusPembatalan(
                                                              doc.id, 'disetujui', item['pesananId'] ?? '');
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(content: Text('Pembatalan disetujui')));
                                                          }
                                                        },
                                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(60, 30)),
                                                        child: const Text("Setuju", style: TextStyle(fontSize: 9, color: Colors.white)),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await FirebaseService.updateStatusPembatalan(
                                                              doc.id, 'ditolak', item['pesananId'] ?? '');
                                                          if (context.mounted) {
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(content: Text('Pembatalan ditolak')));
                                                          }
                                                        },
                                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(60, 30)),
                                                        child: const Text("Tolak", style: TextStyle(fontSize: 9, color: Colors.white)),
                                                      ),
                                                    ],
                                                  )
                                                : const Center(child: Text("-", style: TextStyle(fontWeight: FontWeight.bold))),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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

class _TableHeader extends StatelessWidget {
  final String title;
  final double width;
  const _TableHeader({required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(title, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final double width;
  const _TableCell({required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(text, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
