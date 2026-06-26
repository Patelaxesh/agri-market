import 'package:flutter/material.dart';

/// 1. NOTIFICATION DATA MODEL
class NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String time;
  final bool unread;
  final String section; // e.g., "Today" or "Yesterday"

  const NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
    required this.section,
    this.unread = false,
  });
}

/// 2. MAIN NOTIFICATIONS SCREEN
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  // Clean, decoupled mock data source
  static const List<NotificationItem> _mockNotifications = [
    NotificationItem(
      icon: Icons.shopping_bag,
      iconColor: Colors.green,
      title: "Order Confirmed",
      message: "Your order #AG10245 has been confirmed by the farmer.",
      time: "10 min ago",
      section: "Today",
      unread: true,
    ),
    NotificationItem(
      icon: Icons.local_shipping,
      iconColor: Colors.orange,
      title: "Order Shipped",
      message: "Your order is on the way and will arrive soon.",
      time: "1 hour ago",
      section: "Today",
    ),
    NotificationItem(
      icon: Icons.local_offer,
      iconColor: Colors.deepOrange,
      title: "Special Offer",
      message: "Get 10% off on fresh vegetables this week.",
      time: "Yesterday",
      section: "Yesterday",
    ),
    NotificationItem(
      icon: Icons.payment,
      iconColor: Colors.blue,
      title: "Payment Successful",
      message: "Your payment of ₹2,500 was completed successfully.",
      time: "Yesterday",
      section: "Yesterday",
    ),
    NotificationItem(
      icon: Icons.check_circle,
      iconColor: Colors.green,
      title: "Order Delivered",
      message: "Your order was delivered successfully.",
      time: "2 days ago",
      section: "Yesterday",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F3),
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement read-all functionality
            },
            child: const Text(
              "Read All",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Header Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2E7D32),
                    Color(0xFF43A047),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2E7D32).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 55,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Stay Updated",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Track orders, offers and important updates.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            /// Dynamic, Optimized Notification List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _mockNotifications.length,
                itemBuilder: (context, index) {
                  final notification = _mockNotifications[index];

                  // Logic to display section headers cleanly ("Today", "Yesterday")
                  bool showSectionHeader = false;
                  if (index == 0) {
                    showSectionHeader = true;
                  } else {
                    final prevNotification = _mockNotifications[index - 1];
                    if (prevNotification.section != notification.section) {
                      showSectionHeader = true;
                    }
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showSectionHeader) ...[
                        if (index > 0) const SizedBox(height: 16),
                        Text(
                          notification.section,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      _NotificationCard(notification: notification),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 3. PRIVATE EXTRACTED WIDGET FOR CLEAN ARCHITECTURE
class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          // Ultra-smooth, elegant shadow profile
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: notification.iconColor.withOpacity(.12),
            child: Icon(
              notification.icon,
              color: notification.iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    if (notification.unread)
                      Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: NotificationsScreen.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  notification.message,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.4,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notification.time,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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