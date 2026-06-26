import 'package:flutter/material.dart';

class FarmerFaqsScreen extends StatelessWidget {
  const FarmerFaqsScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F3),
      appBar: AppBar(
        title: const Text('FAQ'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            _FAQTile(
              question: 'How do I add a product?',
              answer:
              'Go to Products screen and tap the Add Product button. Fill in product details, quantity, price, and submit.',
            ),
            SizedBox(height: 10),

            _FAQTile(
              question: 'How do I receive orders?',
              answer:
              'When a vendor places an order, you will receive a notification and can view it in the Orders screen.',
            ),
            SizedBox(height: 10),

            _FAQTile(
              question: 'How do payments work?',
              answer:
              'Payments are processed after successful order completion and will appear in your Earnings section.',
            ),
            SizedBox(height: 10),

            _FAQTile(
              question: 'How do I edit my profile?',
              answer:
              'Open Profile and tap Edit Profile to update your information.',
            ),
            SizedBox(height: 10),

            _FAQTile(
              question: 'How do I update product quantity?',
              answer:
              'Open your product from the Products screen and edit the available quantity.',
            ),
            SizedBox(height: 10),

            _FAQTile(
              question: 'Can I delete a product?',
              answer:
              'Yes. Open the product details and select Delete Product.',
            ),
            SizedBox(height: 10),

            _FAQTile(
              question: 'How can I contact support?',
              answer:
              'Open the Help & Support screen and choose Email Support or Call Support.',
            ),
            SizedBox(height: 10),

            _FAQTile(
              question: 'What if a vendor cancels an order?',
              answer:
              'Cancelled orders will be updated automatically in your Orders section.',
            ),
          ],
        ),
      ),
    );
  }
}

class _FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FAQTile({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        iconColor: FarmerFaqsScreen.primaryColor,
        collapsedIconColor: Colors.grey,
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              16,
            ),
            child: Text(
              answer,
              style: const TextStyle(
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}