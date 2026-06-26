import 'package:flutter/material.dart';
import 'package:agrimarket/features/farmer/screens/farmer_dashboard_screen.dart';
import 'package:agrimarket/features/farmer/screens/farmer_my_products_screen.dart';
import 'package:agrimarket/features/farmer/screens/farmer_orders_screen.dart';
import 'package:agrimarket/features/farmer/screens/farmer_earnings_screen.dart';
import 'package:agrimarket/features/farmer/screens/farmer_profile_screen.dart';

class FarmerBottomNavScreen extends StatefulWidget {
  const FarmerBottomNavScreen({super.key});

  @override
  State<FarmerBottomNavScreen> createState() => _FarmerBottomNavScreenState();
}

class _FarmerBottomNavScreenState extends State<FarmerBottomNavScreen> {
  int _selectedIndex = 0;

  static const Color primaryColor = Color(0xFF2E7D32);

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = const [
      FarmerDashboardScreen(),
      FarmerMyProductsScreen(),
      FarmerOrdersScreen(),
      FarmerEarningsScreen(),
      FarmerProfileScreen(),
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

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: primaryColor.withValues(alpha: 0.15),

          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: primaryColor, size: 28);
            }

            return const IconThemeData(color: Colors.grey, size: 24);
          }),

          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              );
            }

            return const TextStyle(color: Colors.grey);
          }),
        ),

        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onDestinationSelected,
          height: 75,
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,

          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),

            NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2),
              label: 'Products',
            ),

            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              selectedIcon: Icon(Icons.shopping_bag),
              label: 'Orders',
            ),

            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet),
              label: 'Earnings',
            ),

            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
