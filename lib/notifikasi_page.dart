import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF1F1),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ================= NOTIFIKASI 1 =================
          buildNotificationCard(
            icon: Icons.access_time_filled,
            iconColor: Colors.orange,
            iconBg: Colors.orange.shade100,
            title: "Pesanan Sedang Diproses",
            message: "Pesanan Anda sedang diproses oleh admin. "
                "Silakan menunggu maksimal 1x24 jam untuk konfirmasi.",
            time: "Baru saja",
          ),

          const SizedBox(height: 14),

          // ================= NOTIFIKASI 2 =================
          buildNotificationCard(
            icon: Icons.cancel,
            iconColor: Colors.red,
            iconBg: Colors.red.shade100,
            title: "Pembatalan Sedang Diproses",
            message: "Pembatalan pesanan Anda sedang diproses admin. "
                "Silakan menunggu konfirmasi maksimal 1x24 jam.",
            time: "Baru saja",
          ),
        ],
      ),
    );
  }

  // ================= WIDGET NOTIFIKASI =================
  static Widget buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String message,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= ICON =================
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          // ================= TEXT =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
