import 'package:flutter/material.dart';
import 'package:flutter_application_1/Welcome.dart';
import 'package:flutter_application_1/firebase_service.dart';
import 'package:flutter_application_1/loginadmin_page.dart';
import 'forgetpassword_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // ================= HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ================= BACK BUTTON =================
                  IconButton(
                    onPressed: () {
                      // KEMBALI KE WELCOME PAGE
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomePage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black,
                    ),
                  ),

                  // ================= ADMIN BUTTON =================
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginAdminPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Admin",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF2340C7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // ================= TITLE =================
              const Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2340C7),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= SUBTITLE =================
              const Center(
                child: Text(
                  "Selamat datang kembali\nKe\nRidu Sianturi Catering",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    height: 1.4,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ================= EMAIL =================
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email/No. Telepon",
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFEFEFF7),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 22,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFF2340C7),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFF2340C7),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= PASSWORD =================
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFEFEFF7),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 22,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFF2340C7),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color(0xFF2340C7),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // ================= FORGET PASSWORD =================
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Forget your password?",
                    style: TextStyle(
                      color: Color(0xFF2340C7),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ================= SIGN IN BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Email dan password wajib diisi')),
                      );
                      return;
                    }

                    // ======= LOGIN VIA FIREBASE AUTH =======
                    // Memvalidasi email+password dan cek role='pelanggan'
                    final result = await FirebaseService.loginPelanggan(
                      email: email,
                      password: password,
                    );

                    if (!mounted) return;

                    if (result['success'] == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(result['message'] ?? 'Login gagal'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2340C7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= TEXT ATAU =================
              const Center(
                child: Text(
                  "Atau",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= GOOGLE BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2340C7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google_logo.png',
                        height: 28,
                        width: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Lanjut dengan Google",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
}
