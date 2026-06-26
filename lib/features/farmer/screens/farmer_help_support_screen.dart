import 'package:flutter/material.dart';

class FarmerHelpSupportScreen extends StatelessWidget {
  const FarmerHelpSupportScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F3),

      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'How can we help you?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Our support team is here to help you with any issues.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _SupportCard(
              icon: Icons.bug_report_outlined,
              title: 'Report an Issue',
              subtitle: 'Report app bugs or technical problems',
              onTap: () {},
            ),

            const SizedBox(height: 12),

            _SupportCard(
              icon: Icons.help_outline,
              title: 'Get Help',
              subtitle: 'Learn how to use AgriMarket',
              onTap: () {},
            ),

            const SizedBox(height: 12),

            _SupportCard(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'support@agrimarket.com',
              onTap: () {},
            ),

            const SizedBox(height: 12),

            _SupportCard(
              icon: Icons.phone_outlined,
              title: 'Call Support',
              subtitle: '+91 98765 43210',
              onTap: () {},
            ),

            const SizedBox(height: 12),

            _SupportCard(
              icon: Icons.chat_outlined,
              title: 'Live Chat',
              subtitle: 'Chat with our support team',
              onTap: () {},
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Text(
                    'Support Hours',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Monday - Saturday',
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 5),

                  Text(
                    '9:00 AM - 6:00 PM',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
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

class _SupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        leading: CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xFFE8F5E9),
          child: Icon(
            icon,
            color: FarmerHelpSupportScreen.primaryColor,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(subtitle),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),

        onTap: onTap,
      ),
    );
  }
}