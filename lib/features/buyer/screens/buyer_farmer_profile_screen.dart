import 'package:agrimarket/features/buyer/screens/buyer_product_details_screen.dart';
import 'package:flutter/material.dart';

class BuyerFarmerProfileScreen extends StatelessWidget {
  const BuyerFarmerProfileScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(title: const Text('Farmer Profile'), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Farmer Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor.withValues(alpha: 0.1),
              child: const Icon(
                Icons.agriculture,
                size: 50,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Ramesh Patel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '4.8 Rating',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Info Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _infoRow(Icons.location_on_outlined, 'Village', 'Bharuch'),

                  const Divider(),

                  _infoRow(Icons.route_outlined, 'Distance', '3 km Away'),

                  const Divider(),

                  _infoRow(
                    Icons.inventory_2_outlined,
                    'Products',
                    '12 Available',
                  ),

                  const Divider(),

                  _infoRow(
                    Icons.check_circle_outline,
                    'Orders Completed',
                    '245',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // About Farmer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Farmer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Organic farmer with more than 10 years of experience. '
                    'Specialized in vegetables, fruits, and grains with a focus on quality and sustainability.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Products Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 16),

            _productCard(
              context,
              'Fresh Tomatoes',
              '₹28/kg',
              '500 Kg Available',
            ),

            const SizedBox(height: 12),

            _productCard(
              context,
              'Organic Potatoes',
              '₹24/kg',
              '1 Ton Available',
            ),

            const SizedBox(height: 12),

            _productCard(context, 'Fresh Onions', '₹22/kg', '800 Kg Available'),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: primaryColor),

        const SizedBox(width: 12),

        Text(title),

        const Spacer(),

        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _productCard(
    BuildContext context,
    String productName,
    String price,
    String quantity,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 8),

          Text(
            price,
            style: const TextStyle(
              fontSize: 15,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Text(quantity),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyerProductDetailsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              child: const Text(
                'View Product',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
