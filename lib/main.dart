import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'welcome.dart';

// 2. Tambahkan kata kunci 'async' di sini
void main() async {
  // 3. Wajib ditambahkan agar sistem Flutter siap mengeksekusi kode native (Firebase)
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Menginisialisasi Firebase menggunakan file google-services.json yang kamu taruh kemarin
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Tambahkan const jika diperlukan
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
