import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginadmin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangePasswordPageScreen(),
    );
  }
}

class ChangePasswordPageScreen extends StatefulWidget {
  const ChangePasswordPageScreen({super.key});

  @override
  State<ChangePasswordPageScreen> createState() =>
      _ChangePasswordPageScreenState();
}

class _ChangePasswordPageScreenState extends State<ChangePasswordPageScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscureOld = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  void changePassword() {
    String oldPass = oldPasswordController.text;
    String newPass = newPasswordController.text;
    String confirmPass = confirmPasswordController.text;

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field harus diisi")),
      );
      return;
    }

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak cocok")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password berhasil diganti"),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginAdminPage(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F2F6),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 38),
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                "Enter password lama, baru, dan konfirmasi password.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8E8E93),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              buildPasswordField(
                controller: oldPasswordController,
                hintText: "Password lama",
                obscureText: obscureOld,
                onToggle: () {
                  setState(() {
                    obscureOld = !obscureOld;
                  });
                },
              ),
              const SizedBox(height: 16),
              buildPasswordField(
                controller: newPasswordController,
                hintText: "Password baru",
                obscureText: obscureNew,
                onToggle: () {
                  setState(() {
                    obscureNew = !obscureNew;
                  });
                },
              ),
              const SizedBox(height: 16),
              buildPasswordField(
                controller: confirmPasswordController,
                hintText: "Konfirmasi Password",
                obscureText: obscureConfirm,
                onToggle: () {
                  setState(() {
                    obscureConfirm = !obscureConfirm;
                  });
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F49C6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    "Konfirmasi",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return SizedBox(
      height: 74,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 18,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: const Color(0xFFF1F2F8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
