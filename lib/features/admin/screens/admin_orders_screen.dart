import 'package:agrimarket/features/admin/screens/admin_order_details_screen.dart';
import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF6F8FA);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: const Text(
            'Orders',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          bottom: const TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primaryColor,
            indicatorWeight: 3,
            isScrollable: false,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Pending (15)'),
              Tab(text: 'Active (48)'),
              Tab(text: 'Completed (177)'),
            ],
          ),
        ),
        body: const Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  AdminOrdersList(status: 'Pending'),
                  AdminOrdersList(status: 'Active'),
                  AdminOrdersList(status: 'Completed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminOrdersList extends StatelessWidget {
  final String status;

  const AdminOrdersList({super.key, required this.status});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': 'AGM1001',
        'vendor': 'Raj Traders',
        'farmer': 'Rahul Patel',
        'product': 'Fresh Tomatoes',
        'quantity': '20 Kg',
        'amount': '₹600',
        'paymentStatus': 'Paid',
        'date': '12 Jun 2026',
      },
      {
        'id': 'AGM1002',
        'vendor': 'Fresh Mart',
        'farmer': 'Amit Sharma',
        'product': 'Organic Potatoes',
        'quantity': '15 Kg',
        'amount': '₹375',
        'paymentStatus': 'Pending',
        'date': '11 Jun 2026',
      },
      {
        'id': 'AGM1003',
        'vendor': 'Green Store',
        'farmer': 'Jay Patel',
        'product': 'Red Onions',
        'quantity': '25 Kg',
        'amount': '₹350',
        'paymentStatus': 'Refunded',
        'date': '10 Jun 2026',
      },
    ];

    return Column(
      children: [
        /// Summary Metrics Row Blocks
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Row(
            children: [
              Expanded(
                child: _buildRevenueBlock('Total Orders', '240', Colors.blue),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildRevenueBlock(
                  'Revenue',
                  '₹1.25L',
                  const Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
        ),

        /// Search Bar Box Row with Filter Option Icon
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search orders...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: primaryColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: primaryColor,
                  size: 22,
                ),
              ),
            ],
          ),
        ),

        /// Product Cards Pipeline Scroll List View
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              void navigateToDetails() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminOrderDetailsScreen(
                      order: Map<String, String>.from(order),
                    ),
                  ),
                );
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04), // Updated to withValues
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: InkWell(
                    onTap: navigateToDetails,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Text Unique Custom ID Tag Block representation
                              Container(
                                height: 60,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: primaryColor.withValues(alpha: 0.1), // Updated to withValues
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  order['id']!,
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            order['product']!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        _statusChip(status),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      order['quantity']!,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    _iconDetailLabel(
                                      Icons.storefront_rounded,
                                      'Vendor: ${order['vendor']}',
                                    ),
                                    const SizedBox(height: 2),
                                    _iconDetailLabel(
                                      Icons.agriculture_rounded,
                                      'Farmer: ${order['farmer']}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(height: 1),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _iconDetailLabel(
                                Icons.calendar_today_outlined,
                                order['date']!,
                              ),
                              Row(
                                children: [
                                  _buildPaymentChip(order['paymentStatus']!),
                                  const SizedBox(width: 8),
                                  Text(
                                    order['amount']!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 46,
                            child: OutlinedButton(
                              onPressed: navigateToDetails,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              child: const Text('View Order Details'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueBlock(String title, String val, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            val,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconDetailLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade400),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      ],
    );
  }

  Widget _statusChip(String status) {
    Color color;
    switch (status) {
      case 'Pending':
        color = Colors.orange;
        break;
      case 'Active':
        color = Colors.blue;
        break;
      case 'Completed':
        color = const Color(0xFF2E7D32);
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1), // Updated to withValues
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12.5,
        ),
      ),
    );
  }

  Widget _buildPaymentChip(String paymentStatus) {
    Color baseColor;
    switch (paymentStatus) {
      case 'Paid':
        baseColor = const Color(0xFF2E7D32);
        break;
      case 'Pending':
        baseColor = Colors.orange.shade800;
        break;
      default:
        baseColor = const Color(0xFFC62828);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.08), // Updated to withValues
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        paymentStatus,
        style: TextStyle(
          color: baseColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}