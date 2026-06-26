import 'package:flutter/material.dart';

class AdminAboutAppScreen extends StatelessWidget {
  const AdminAboutAppScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF5F7F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'About App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// App Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, Color(0xFF1B5E20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.agriculture,
                      size: 42,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'AgriMarket Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// About Card
            _sectionCard(
              title: 'About',
              child: const Text(
                'AgriMarket is a B2B agricultural marketplace that connects farmers directly with vendors, helping farmers receive fair pricing while simplifying procurement for businesses.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),

            const SizedBox(height: 16),

            /// Features Card
            _sectionCard(
              title: 'Key Features',
              child: const Column(
                children: [
                  FeatureTile('Farmer Management'),
                  FeatureTile('Vendor Management'),
                  FeatureTile('Product Management'),
                  FeatureTile('Order Management'),
                  FeatureTile('Notifications'),
                  FeatureTile('Reports & Analytics'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Contact Card
            _sectionCard(
              title: 'Contact Information',
              child: Column(
                children: const [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.email_outlined),
                    title: Text('support@agrimarket.com'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.language),
                    title: Text('www.agrimarket.com'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              '© 2026 AgriMarket\nAll Rights Reserved',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final String title;

  const FeatureTile(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AdminAboutAppScreen.primaryColor,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}
