import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F3),

      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            _section(
              'Information We Collect',
              'AgriMarket may collect your name, phone number, email address, farm details, product listings, and transaction information to provide marketplace services.',
            ),

            const SizedBox(height: 16),

            _section(
              'How We Use Your Information',
              'Your information is used to create your account, process orders, manage transactions, improve platform performance, and provide customer support.',
            ),

            const SizedBox(height: 16),

            _section(
              'Data Security',
              'We implement appropriate security measures to protect user information against unauthorized access, disclosure, or misuse.',
            ),

            const SizedBox(height: 16),

            _section(
              'Information Sharing',
              'AgriMarket does not sell personal information. Information may be shared only when required to complete transactions or comply with legal obligations.',
            ),

            const SizedBox(height: 16),

            _section(
              'Your Rights',
              'Users can update profile information, request account changes, and contact support regarding privacy-related concerns.',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}