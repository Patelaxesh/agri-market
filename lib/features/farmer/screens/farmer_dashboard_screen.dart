import 'package:agrimarket/features/farmer/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/quick_action_card.dart'; // Contains FarmerQuickActions and QuickActionCard
import '../widgets/market_price_card.dart';
import '../widgets/recent_order_card.dart';

class FarmerDashboardScreen extends StatelessWidget {
  const FarmerDashboardScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row (Profile, Welcome text, and Notification button)
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: primaryColor,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Welcome Back 👋",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Farmer",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                    },
                    icon: const Icon(Icons.notifications_none, size: 28),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Search Input Field
              TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Quick Actions Section
              const Text(
                "Quick Actions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // This calls your newly updated, fully clickable grid widget
              const FarmerQuickActions(),

              const SizedBox(height: 24),

              // Statistics Overview Section
              const Text(
                "Overview",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: const [
                  DashboardCard(
                    title: "Products",
                    value: "12",
                    icon: Icons.inventory,
                    color: Colors.green,
                  ),
                  DashboardCard(
                    title: "Orders",
                    value: "08",
                    icon: Icons.shopping_cart,
                    color: Colors.orange,
                  ),
                  DashboardCard(
                    title: "Revenue",
                    value: "₹25K",
                    icon: Icons.currency_rupee,
                    color: Colors.blue,
                  ),
                  DashboardCard(
                    title: "Pending",
                    value: "03",
                    icon: Icons.pending_actions,
                    color: Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Today's Market Prices Section
              const Text(
                "Today's Market Prices",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const MarketPriceCard(cropName: "Wheat", price: "₹2500/q"),
              const MarketPriceCard(cropName: "Rice", price: "₹3200/q"),
              const MarketPriceCard(cropName: "Maize", price: "₹2200/q"),
              const MarketPriceCard(cropName: "Cotton", price: "₹6800/q"),

              const SizedBox(height: 24),

              // Recent Orders Section
              const Text(
                "Recent Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const RecentOrderCard(
                orderId: "1024",
                productName: "Wheat",
                quantity: "5 Quintal",
                amount: "₹12,500",
              ),
              const RecentOrderCard(
                orderId: "1025",
                productName: "Rice",
                quantity: "3 Quintal",
                amount: "₹9,600",
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
