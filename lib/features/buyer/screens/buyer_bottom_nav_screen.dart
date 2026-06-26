import 'package:flutter/material.dart';

import 'buyer_dashboard_screen.dart';
import 'browse_products_screen.dart';
import 'buyer_cart_screen.dart';
import 'buyer_orders_screen.dart';
import 'buyer_profile_screen.dart';

class BuyerBottomNavScreen extends StatefulWidget {
  const BuyerBottomNavScreen({super.key});

  @override
  State<BuyerBottomNavScreen> createState() => _BuyerBottomNavScreenState();
}

class _BuyerBottomNavScreenState extends State<BuyerBottomNavScreen> {
  int _selectedIndex = 0;

  static const Color primaryColor = Color(0xFF2E7D32);

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = const [
      BuyerDashboardScreen(),
      BrowseProductsScreen(),
      BuyerCartScreen(),
      BuyerOrdersScreen(),
      BuyerProfileScreen(),
    ];
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: primaryColor.withValues(alpha: 0.15),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: primaryColor, size: 28);
              }

              return const IconThemeData(color: Colors.grey, size: 24);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return const TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                );
              }

              return const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            height: 72,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront_rounded),
                label: 'Products',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart_rounded),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long_rounded),
                label: 'Orders',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
