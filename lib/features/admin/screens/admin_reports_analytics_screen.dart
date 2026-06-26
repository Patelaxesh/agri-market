
import 'package:flutter/material.dart';

class AdminReportsAnalyticsScreen extends StatelessWidget {
  const AdminReportsAnalyticsScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF5F7F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'Reports & Analytics',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 1. Revenue Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryColor, Color(0xFF1B5E20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Revenue',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '₹1,25,000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 2. Monthly Performance
            _sectionTitle('Monthly Performance'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _metricRow(
                    'Revenue',
                    '₹1,25,000',
                    Icons.currency_rupee,
                    Colors.green,
                  ),
                  const Divider(),
                  _metricRow(
                    'Orders',
                    '240',
                    Icons.shopping_bag_outlined,
                    Colors.purple,
                  ),
                  const Divider(),
                  _metricRow(
                    'Products',
                    '560',
                    Icons.inventory_2_outlined,
                    Colors.teal,
                  ),
                  const Divider(),
                  _metricRow(
                    'Users',
                    '205',
                    Icons.people_outline,
                    Colors.blue,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 3. Report Overview
            _sectionTitle('Report Overview'),
            _reportSummaryCard(
              'Sales Report',
              '₹1,25,000 Revenue Generated',
              Icons.bar_chart,
              Colors.green,
            ),
            _reportSummaryCard(
              'User Report',
              '205 Active Users',
              Icons.people,
              Colors.blue,
            ),
            _reportSummaryCard(
              'Product Report',
              '560 Products Listed',
              Icons.inventory_2,
              Colors.orange,
            ),
            _reportSummaryCard(
              'Order Report',
              '240 Orders Processed',
              Icons.shopping_cart,
              Colors.purple,
            ),

            const SizedBox(height: 20),

            /// 4. Top Categories
            _sectionTitle('Top Categories'),
            _categoryTile('Vegetables', '320 Products', 0.85),
            _categoryTile('Fruits', '180 Products', 0.65),
            _categoryTile('Grains', '60 Products', 0.35),

            const SizedBox(height: 20),

            /// 5. Top Products
            _sectionTitle('Top Products'),
            _reportSummaryCard(
              'Fresh Tomatoes',
              '120 Orders',
              Icons.eco,
              Colors.red,
            ),
            _reportSummaryCard(
              'Organic Potatoes',
              '95 Orders',
              Icons.eco,
              Colors.orange,
            ),
            _reportSummaryCard(
              'Alphonso Mango',
              '80 Orders',
              Icons.eco,
              Colors.green,
            ),

            const SizedBox(height: 20),

            /// 6. This Month Summary
            _sectionTitle('This Month Summary'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.person_add, color: Colors.green),
                    title: Text('New Farmers'),
                    trailing: Text('25'),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.store, color: Colors.blue),
                    title: Text('New Vendors'),
                    trailing: Text('12'),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.shopping_bag, color: Colors.purple),
                    title: Text('Orders Completed'),
                    trailing: Text('180'),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.currency_rupee, color: Colors.green),
                    title: Text('Revenue Generated'),
                    trailing: Text('₹1.25L'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _metricRow(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportSummaryCard(
      String title,
      String subtitle,
      IconData icon,
      Color color,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryTile(String title, String value, double progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(value, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            color: primaryColor,
            backgroundColor: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}

