import 'package:agrimarket/features/farmer/screens/farmer_add_product_screen.dart';
import 'package:agrimarket/features/farmer/screens/farmer_earnings_screen.dart';
import 'package:agrimarket/features/farmer/screens/farmer_my_products_screen.dart';
import 'package:agrimarket/features/farmer/screens/farmer_orders_screen.dart';
import 'package:flutter/material.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        QuickActionCard(
          title: "Add Product",
          icon: Icons.add_box_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FarmerAddProductScreen()),
            );
          },
        ),

        QuickActionCard(
          title: "My Products",
          icon: Icons.inventory_2_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FarmerMyProductsScreen()),
            );
          },
        ),

        QuickActionCard(
          title: "Orders",
          icon: Icons.shopping_bag_outlined,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FarmerOrdersScreen()),
            );
          },
        ),

        QuickActionCard(
          title: "Earnings",
          icon: Icons.currency_rupee,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FarmerEarningsScreen()),
            );
          },
        ),
      ],
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 28, color: const Color(0xFF2E7D32)),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
