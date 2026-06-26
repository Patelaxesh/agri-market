import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F3),

      appBar: AppBar(
        title: const Text('Terms & Conditions'),
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
              'Account Responsibility',
              'Users are responsible for maintaining the confidentiality of their account credentials and ensuring account information is accurate.',
            ),

            const SizedBox(height: 16),

            _section(
              'Product Listings',
              'Farmers must provide accurate information regarding products, pricing, quantity, and availability.',
            ),

            const SizedBox(height: 16),

            _section(
              'Orders & Payments',
              'All transactions conducted through AgriMarket must follow platform guidelines. Payment processing and settlement timelines may vary.',
            ),

            const SizedBox(height: 16),

            _section(
              'Prohibited Activities',
              'Users must not provide false information, engage in fraudulent activities, misuse the platform, or violate applicable laws.',
            ),

            const SizedBox(height: 16),

            _section(
              'Platform Changes',
              'AgriMarket reserves the right to update features, policies, and terms to improve platform functionality and compliance.',
            ),

            const SizedBox(height: 16),

            _section(
              'Termination',
              'Accounts that violate platform rules may be suspended or permanently removed without prior notice.',
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