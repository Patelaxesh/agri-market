import 'package:agrimarket/features/buyer/screens/buyer_orders_screen.dart';
import 'package:agrimarket/features/buyer/screens/featured_products_screen.dart'; // Imported for Featured Products view all navigation
import 'package:agrimarket/features/buyer/screens/nearby_farmers_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/category_card.dart';
import '../widgets/dashboard_banner.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/featured_product_card.dart';
import '../widgets/nearby_farmer_card.dart';
import '../widgets/recent_order_card.dart';
import '../widgets/search_bar_widget.dart';

class BuyerDashboardScreen extends StatelessWidget {
  const BuyerDashboardScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Dashboard Header
              const DashboardHeader(),

              // 2. Search Bar
              const SearchBarWidget(),

              // 3. Banner Slider
              const DashboardBanner(),

              // 5. Categories
              _sectionTitle(
                'Categories',
                onTap: () {
                  // TODO: Navigate to CategoriesScreen
                },
              ),
              SizedBox(
                height: 135,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: const [
                    CategoryCard(title: 'Vegetables', icon: Icons.eco_rounded),
                    CategoryCard(title: 'Fruits', icon: Icons.apple_rounded),
                    CategoryCard(title: 'Grains', icon: Icons.grass_rounded),
                    CategoryCard(title: 'Pulses', icon: Icons.spa_rounded),
                    CategoryCard(
                      title: 'Spices',
                      icon: Icons.local_florist_rounded,
                    ),
                  ],
                ),
              ),

              // 6. Featured Products
              _sectionTitle(
                'Featured Products',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FeaturedProductsScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 340,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: const [
                    FeaturedProductCard(
                      productName: 'Fresh Tomatoes',
                      farmerName: 'Ramesh Patel',
                      location: 'Bharuch',
                      price: '₹28/kg',
                      quantity: '500 Kg',
                      imageUrl: '',
                    ),
                    FeaturedProductCard(
                      productName: 'Organic Potatoes',
                      farmerName: 'Suresh Bhai',
                      location: 'Ankleshwar',
                      price: '₹24/kg',
                      quantity: '1 Ton',
                      imageUrl: '',
                    ),
                  ],
                ),
              ),

              // 7. Nearby Farmers
              _sectionTitle(
                'Nearby Farmers',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NearbyFarmersScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 320,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: const [
                    NearbyFarmerCard(
                      farmerName: 'Ramesh Patel',
                      village: 'Bharuch',
                      distance: '3 km',
                      productsCount: '12',
                      rating: 4.8,
                    ),
                    NearbyFarmerCard(
                      farmerName: 'Suresh Bhai',
                      village: 'Ankleshwar',
                      distance: '7 km',
                      productsCount: '9',
                      rating: 4.6,
                    ),
                  ],
                ),
              ),

              // 8. Recent Orders
              _sectionTitle(
                'Recent Orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BuyerOrdersScreen(),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    RecentOrderCard(
                      orderId: '#ORD1025',
                      productName: 'Fresh Tomatoes',
                      farmerName: 'Ramesh Patel',
                      quantity: '50 Kg',
                      amount: '₹1,400',
                      status: 'Accepted',
                    ),
                    RecentOrderCard(
                      orderId: '#ORD1024',
                      productName: 'Potatoes',
                      farmerName: 'Suresh Bhai',
                      quantity: '100 Kg',
                      amount: '₹2,800',
                      status: 'Delivered',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(
    String title, {
    bool showViewAll = true,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          if (showViewAll)
            TextButton(onPressed: onTap, child: const Text('View All')),
        ],
      ),
    );
  }
}
