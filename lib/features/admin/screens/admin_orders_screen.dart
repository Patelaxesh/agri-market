import 'package:flutter/material.dart';
import 'package:agrimarket/features/admin/screens/admin_order_details_screen.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF4F6F4);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                elevation: 0,
                pinned: false,
                floating: true,
                centerTitle: false,
                title: const Text(
                  'Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 22,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(72),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      // Prevents tab squishing layout overflows
                      tabAlignment: TabAlignment.start,
                      // Fits scrollable items naturally
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.grey.shade600,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      tabs: const [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.hourglass_empty_rounded, size: 16),
                              SizedBox(width: 6),
                              Text('Pending (15)'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.local_shipping_rounded, size: 16),
                              SizedBox(width: 6),
                              Text('Active (48)'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline_rounded,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text('Completed (177)'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              AdminOrdersList(status: 'Pending'),
              AdminOrdersList(status: 'Active'),
              AdminOrdersList(status: 'Completed'),
            ],
          ),
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
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
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

        /// Search Bar Box Row
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.grey.shade400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.015),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: navigateToDetails,
                    // Full responsive body card click action
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Text Unique Custom ID Tag Block representation
                              Container(
                                height: 54,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  order['id']!,
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
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
                                              fontSize: 15,
                                              color: Colors.black87,
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
                                        fontSize: 13,
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
                          const SizedBox(height: 12),
                          const Divider(height: 1),
                          const SizedBox(height: 12),
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
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: navigateToDetails,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 42),
                                side: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1.5,
                                ),
                                foregroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
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
        Icon(icon, size: 13, color: Colors.grey.shade400),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
    );
  }

  Widget _statusChip(String status) {
    Color color;
    switch (status) {
      case 'Pending':
        color = Colors.orange.shade800;
        break;
      case 'Active':
        color = Colors.blue.shade700;
        break;
      case 'Completed':
        color = const Color(0xFF2E7D32);
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        paymentStatus,
        style: TextStyle(
          color: baseColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
