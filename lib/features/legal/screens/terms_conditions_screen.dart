import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F8FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: primaryColor.withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.gavel_rounded,
                      size: 42,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please read these terms carefully before using AgriMarket.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Last Updated
            _infoCard(
              icon: Icons.calendar_today,
              title: "Last Updated",
              content: "15 June 2026",
            ),

            // All Sections
            _infoCard(
              icon: Icons.person_outline,
              title: "User Eligibility",
              content: "Users must be at least 18 years old and capable of entering into legally binding agreements.",
            ),

            _infoCard(
              icon: Icons.account_circle_outlined,
              title: "Account Registration",
              content: "Users must provide accurate information during registration and keep account credentials secure.",
            ),

            _infoCard(
              icon: Icons.agriculture,
              title: "Farmer Responsibilities",
              content: "Farmers must provide accurate product information, pricing, stock availability, and quality produce.",
            ),

            _infoCard(
              icon: Icons.storefront_outlined,
              title: "Buyer Responsibilities",
              content: "Buyers must place genuine orders, provide correct delivery information, and complete payments on time.",
            ),

            _infoCard(
              icon: Icons.payments_outlined,
              title: "Orders & Payments",
              content: "All payments must be completed through approved payment methods. AgriMarket may verify transactions for security.",
            ),

            _infoCard(
              icon: Icons.local_shipping_outlined,
              title: "Delivery & Logistics",
              content: "Delivery timelines may vary based on location, availability, weather conditions, and logistics partners.",
            ),

            _infoCard(
              icon: Icons.block_outlined,
              title: "Prohibited Activities",
              content: "Fraud, false listings, misleading information, abusive behavior, and misuse of the platform are strictly prohibited.",
            ),

            _infoCard(
              icon: Icons.cancel_outlined,
              title: "Suspension & Termination",
              content: "AgriMarket reserves the right to suspend or terminate accounts that violate platform policies.",
            ),

            _infoCard(
              icon: Icons.shield_outlined,
              title: "Limitation of Liability",
              content: "AgriMarket acts as a marketplace platform and is not liable for indirect losses arising from transactions.",
            ),

            _infoCard(
              icon: Icons.update,
              title: "Changes to Terms",
              content: "AgriMarket may update these terms from time to time. Continued use of the platform indicates acceptance.",
            ),

            const SizedBox(height: 24),

            // Agreement Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.verified_user,
                    color: primaryColor,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "By using AgriMarket, you agree to comply with these Terms & Conditions.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              "AgriMarket v1.0.0",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            const Text(
              "Connecting Farmers & Buyers",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: primaryColor.withValues(alpha: 0.1),
            radius: 24,
            child: Icon(icon, color: primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    color: Colors.grey[700],
                    height: 1.45,
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