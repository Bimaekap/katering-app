import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';

class KelolaPelangganPage extends StatefulWidget {
  const KelolaPelangganPage({super.key});

  @override
  State<KelolaPelangganPage> createState() => _KelolaPelangganPageState();
}

class _KelolaPelangganPageState extends State<KelolaPelangganPage> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
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
                decoration: BoxDecoration(
                  color: const Color(0xffD7E0E5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black54),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Ridu Sianturi\nCatering",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff2447C6)),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 38, height: 38,
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

              // ================= DASHBOARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(color: const Color(0xffD7E0E5), borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  children: [
                    Icon(Icons.home_outlined, size: 20),
                    SizedBox(width: 10),
                    Expanded(child: Text("Dashboard Admin / Mengelola Pelanggan",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ================= SEARCH =================
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff2447C6), width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (v) => setState(() => searchQuery = v),
                        style: const TextStyle(fontSize: 11),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Cari nama, nomor, email",
                          hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                    ),
                    const Icon(Icons.search, size: 18),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Data Pelanggan", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 10),

              // ================= TABLE DATA (FIRESTORE REALTIME) =================
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseService.streamPelanggan(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('Belum ada data pelanggan'));
                    }

                    final docs = snapshot.data!.docs.where((doc) {
                      final d = doc.data() as Map<String, dynamic>;
                      final q = searchQuery.toLowerCase();
                      return q.isEmpty ||
                          (d['nama'] ?? '').toString().toLowerCase().contains(q) ||
                          (d['noHp'] ?? '').toString().toLowerCase().contains(q) ||
                          (d['email'] ?? '').toString().toLowerCase().contains(q);
                    }).toList();

                    return Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: 700,
                          child: ListView.builder(
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              final d = docs[index].data() as Map<String, dynamic>;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffE2E5E8),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    SizedBox(width: 30, child: Text('${index + 1}.', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                                    SizedBox(width: 90, child: Text(d['nama'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                                    SizedBox(width: 110, child: Text(d['noHp'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                                    SizedBox(width: 160, child: Text(d['email'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                                    SizedBox(width: 140, child: Text(d['alamat'] ?? '-', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.edit, color: Colors.indigo, size: 18),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // ================= FOOTER =================
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: const Color(0xffE2E5E8), borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  children: [
                    Text("Data Pelanggan (realtime)", style: TextStyle(color: Colors.grey, fontSize: 10)),
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
