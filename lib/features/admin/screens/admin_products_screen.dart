import 'package:flutter/material.dart';

import 'admin_product_details_screen.dart';

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    // Extended product list containing multiple state flows for button testing variations
    final products = [
      {
        'name': 'Fresh Tomatoes',
        'farmer': 'Rahul Patel',
        'price': '₹30/kg',
        'category': 'Vegetables',
        'status': 'Pending',
      },
      {
        'name': 'Organic Potatoes',
        'farmer': 'Amit Sharma',
        'price': '₹25/kg',
        'category': 'Vegetables',
        'status': 'Approved',
      },
      {
        'name': 'Wheat',
        'farmer': 'Jay Patel',
        'price': '₹40/kg',
        'category': 'Grains',
        'status': 'Approved',
      },
      {
        'name': 'Rice',
        'farmer': 'Kiran Kumar',
        'price': '₹55/kg',
        'category': 'Grains',
        'status': 'Rejected',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),

      /// 1. Updated Modern AppBar Configuration
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          /// 2. Clean Status Summary Metrics Grid Block Row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.1,
              children: [
                _buildSummaryBlock('Total', '560', Colors.blue),
                _buildSummaryBlock('Approved', '520', Colors.green),
                _buildSummaryBlock('Pending', '25', Colors.orange),
                _buildSummaryBlock('Rejected', '15', Colors.red),
              ],
            ),
          ),

          /// 6. Search Bar Layout Row Container with contextual configuration options tool block
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
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

          /// Product Infinite Flow Scroll List Pipeline
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final String name = product['name']!;
                final String status = product['status']!;
                final String initial = name.isNotEmpty ? name[0] : '?';

                void navigateToDetails() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AdminProductDetailsScreen(productData: product),
                    ),
                  );
                }

                /// 5. InkWell Wrapper around the Entire ClipRRect layout structure makes the entire card body clickable
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.015),
                        // Updated to withValues
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: navigateToDetails,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// 4. Avatar design replacing the large green box icon
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: primaryColor.withValues(
                                    alpha: 0.1,
                                  ), // Updated to withValues
                                  child: Text(
                                    initial,
                                    style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              name,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),

                                          /// 3. Standard Status Chip dynamic implementation block
                                          _buildStatusChip(status),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      _iconDetailLabel(
                                        Icons.person_outline_rounded,
                                        'Farmer: ${product['farmer']}',
                                      ),
                                      const SizedBox(height: 4),
                                      _iconDetailLabel(
                                        Icons.category_outlined,
                                        product['category']!,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        product['price']!,
                                        style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            /// 7. Adaptive action buttons logic depending on actual status flows
                            _buildActionRow(status, navigateToDetails),
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
      ),
    );
  }

  Widget _buildSummaryBlock(String title, String val, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            val,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconDetailLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey.shade500),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color baseColor;
    switch (status) {
      case 'Approved':
        baseColor = const Color(0xFF2E7D32);
        break;
      case 'Pending':
        baseColor = Colors.orange.shade800;
        break;
      default:
        baseColor = const Color(0xFFC62828);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.08), // Updated to withValues
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: baseColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionRow(String status, VoidCallback onViewDetails) {
    if (status == 'Approved') {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onViewDetails,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 42),
            side: BorderSide(color: Colors.grey.shade200, width: 1.5),
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          child: const Text('View Details'),
        ),
      );
    } else if (status == 'Pending') {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE8F5E9),
                foregroundColor: const Color(0xFF2E7D32),
                elevation: 0,
                minimumSize: const Size(0, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              child: const Text('Approve'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFEBEE),
                foregroundColor: const Color(0xFFC62828),
                elevation: 0,
                minimumSize: const Size(0, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              child: const Text('Reject'),
            ),
          ),
        ],
      );
    } else {
      // Status is Rejected
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onViewDetails,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 42),
                side: BorderSide(color: Colors.grey.shade200, width: 1.5),
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              child: const Text('View'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE3F2FD),
                foregroundColor: const Color(0xFF1565C0),
                elevation: 0,
                minimumSize: const Size(0, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              child: const Text('Restore'),
            ),
          ),
        ],
      );
    }
  }
}
