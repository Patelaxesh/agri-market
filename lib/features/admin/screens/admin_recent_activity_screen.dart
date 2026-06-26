import 'package:flutter/material.dart';

class AdminRecentActivityScreen extends StatelessWidget {
  const AdminRecentActivityScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF5F7F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Recent Activities',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // --- TODAY SECTION ---
          _SectionHeader(title: 'Today'),
          ActivityItem(
            icon: Icons.person_add_alt_1_outlined,
            color: Colors.orange,
            title: 'New Farmer Registered',
            subtitle: 'Rahul Patel from Surat joined the platform.',
            time: '2m ago',
          ),
          ActivityItem(
            icon: Icons.store_outlined,
            color: Colors.blue,
            title: 'New Vendor Registered',
            subtitle: 'Fresh Mart Vendor account created.',
            time: '5m ago',
          ),
          ActivityItem(
            icon: Icons.add_box_outlined,
            color: Colors.teal,
            title: 'New Product Added',
            subtitle: 'Alphonso Mangoes listed by Ramesh K.',
            time: '10m ago',
          ),
          ActivityItem(
            icon: Icons.shopping_cart_checkout_outlined,
            color: Colors.purple,
            title: 'Order Placed',
            subtitle: 'Order #AM-94827 placed successfully.',
            time: '15m ago',
          ),

          SizedBox(height: 12), // Spacing between sections

          // --- YESTERDAY SECTION ---
          _SectionHeader(title: 'Yesterday'),
          ActivityItem(
            icon: Icons.check_circle_outline,
            color: Colors.green,
            title: 'Order Completed',
            subtitle: 'Order #AM-94827 delivered successfully.',
            time: 'Yesterday',
          ),
          ActivityItem(
            icon: Icons.payments_outlined,
            color: Colors.indigo,
            title: 'Payment Received',
            subtitle: '₹12,500 payment received from vendor.',
            time: 'Yesterday',
          ),

          SizedBox(height: 12), // Spacing between sections

          // --- EARLIER SECTION ---
          _SectionHeader(title: 'Earlier'),
          ActivityItem(
            icon: Icons.verified_user_outlined,
            color: Colors.deepOrange,
            title: 'Farmer Approved',
            subtitle: 'Admin approved a farmer account.',
            time: '2 days ago',
          ),
          ActivityItem(
            icon: Icons.inventory_2_outlined,
            color: Colors.brown,
            title: 'Product Approved',
            subtitle: 'Fresh Tomatoes listing approved.',
            time: '3 days ago',
          ),
        ],
      ),
    );
  }
}

// A dedicated helper widget to keep the section titles looking clean and uniform
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12, top: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}