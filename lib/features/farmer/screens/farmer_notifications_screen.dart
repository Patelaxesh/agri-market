import 'package:flutter/material.dart';

class FarmerNotificationsScreen extends StatelessWidget {
  const FarmerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF1B5E20),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF1B5E20)),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            icon: Icons.shopping_bag,
            iconColor: Colors.orange,
            title: 'New Order Received',
            message: 'Vendor Rajesh placed an order for 50kg Tomatoes.',
            time: '2 min ago',
          ),

          SizedBox(height: 12),

          NotificationCard(
            icon: Icons.payments,
            iconColor: Colors.green,
            title: 'Payment Received',
            message: '₹2,500 payment received successfully.',
            time: '1 hour ago',
          ),

          SizedBox(height: 12),

          NotificationCard(
            icon: Icons.check_circle,
            iconColor: Colors.blue,
            title: 'Order Completed',
            message: 'Your Potato order has been completed.',
            time: '3 hours ago',
          ),

          SizedBox(height: 12),

          NotificationCard(
            icon: Icons.inventory_2,
            iconColor: Colors.purple,
            title: 'Product Approved',
            message: 'Your Tomato listing is now live.',
            time: 'Yesterday',
          ),

          SizedBox(height: 12),

          NotificationCard(
            icon: Icons.info,
            iconColor: Colors.red,
            title: 'System Update',
            message: 'New AgriMarket features are available.',
            time: '2 days ago',
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String time;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: iconColor.withValues(alpha: 0.15),
              child: Icon(icon, color: iconColor),
            ),

            const SizedBox(width: 14),

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

                  const SizedBox(height: 4),

                  Text(
                    message,
                    style: const TextStyle(color: Colors.black54, height: 1.4),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
