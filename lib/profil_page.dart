import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page.dart';
import 'home_page.dart';
import 'riwayat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil User UI',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // =========================
      // BOTTOM NAVIGATION BAR
      // =========================
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF3B5998),
              width: 2.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,

          // =========================
          // NAVIGATOR ICON
          // =========================
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });

            // HOME
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }

            // RIWAYAT
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RiwayatPage(),
                ),
              );
            }
          },

          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 26),
              activeIcon: Icon(Icons.home, size: 26),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined, size: 26),
              activeIcon: Icon(Icons.article, size: 26),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 26),
              activeIcon: Icon(Icons.person, size: 26),
              label: '',
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // =========================
            // HEADER
            // =========================
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: BackgroundClipper(),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    color: const Color(0xFFB5C3C6),
                  ),
                ),

                // BACK BUTTON
                Positioned(
                  top: 5,
                  left: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),

                // TITLE
                const Positioned(
                  top: 18,
                  child: Text(
                    'Profil User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // LOGOUT BUTTON
                // ================= LOGOUT BUTTON =================
                Positioned(
                  top: 12,
                  right: 10,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                // PROFILE IMAGE
                Positioned(
                  bottom: -40,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/profil_logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // EDIT BUTTON
                      Positioned(
                        bottom: -3,
                        right: -3,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Edit Foto Profil'),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: Color(0xFFEFEFEF),
                              child: Icon(
                                Icons.edit,
                                size: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 45),

            // =========================
            // USER INFO
            // =========================
            const Text(
              'Dyren',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 2),

            const Text(
              'dyren@gmail.com | +62 234 567 89',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            // =========================
            // MENU
            // =========================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                children: [
                  buildMenuCard(
                    children: [
                      customListTile(
                        context,
                        icon: Icons.badge_outlined,
                        title: 'Edit profile information',
                      ),
                      customListTile(
                        context,
                        icon: Icons.notifications_none_outlined,
                        title: 'Notifications',
                        trailingText: 'ON',
                      ),
                      customListTile(
                        context,
                        icon: Icons.language,
                        title: 'Language',
                        trailingText: 'English',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildMenuCard(
                    children: [
                      customListTile(
                        context,
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                      ),
                      customListTile(
                        context,
                        icon: Icons.chat_bubble_outline,
                        title: 'Contact us',
                      ),
                      customListTile(
                        context,
                        icon: Icons.lock_outline,
                        title: 'Privacy policy',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // CARD MENU
  // =========================
  Widget buildMenuCard({
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black12,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  // =========================
  // CUSTOM LIST TILE
  // =========================
  Widget customListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? trailingText,
  }) {
    return ListTile(
      minVerticalPadding: 0,
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(
        icon,
        size: 20,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
        ),
      ),
      trailing: trailingText != null
          ? Text(
              trailingText,
              style: const TextStyle(
                color: Color(0xFF1B74E4),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            )
          : const Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: Colors.black45,
            ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title clicked'),
          ),
        );
      },
    );
  }
}

// =========================
// CUSTOM CLIPPER
// =========================
class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 28);

    Offset controlPoint = Offset(
      size.width / 2,
      size.height + 12,
    );

    Offset endPoint = Offset(
      size.width,
      size.height - 28,
    );

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
