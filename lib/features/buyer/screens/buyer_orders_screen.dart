
import 'package:agrimarket/features/buyer/screens/buyer_order_details_screen.dart';
import 'package:agrimarket/features/buyer/screens/track_order_screen.dart';
import 'package:agrimarket/features/buyer/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class BuyerOrdersScreen extends StatelessWidget {
  const BuyerOrdersScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6F8FA),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'My Orders',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20, // 1. Updated AppBar Title size
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
              Tab(text: 'Pending'),
              Tab(text: 'Ongoing'), // 7. Updated Tab Name
              Tab(text: 'Delivered'), // 7. Updated Tab Name
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by Order ID or Product...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  // 2. Updated Search Field Borders
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: BuyerOrdersScreen.primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const Expanded(
              child: TabBarView(
                children: [
                  OrdersList(status: 'Pending'),
                  OrdersList(status: 'Ongoing'), // 7. Updated Status pass
                  OrdersList(status: 'Delivered'), // 7. Updated Status pass
                  OrdersList(status: 'Cancelled'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  final String status;
  const OrdersList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': '#AGM1001',
        'product': 'Fresh Tomatoes',
        'farmer': 'Rahul Patel',
        'quantity': '20 Kg',
        'amount': '₹600',
        'location': 'Surat',
        'date': '12 Jun 2026',
      },
      {
        'id': '#AGM1002',
        'product': 'Organic Potato',
        'farmer': 'Amit Sharma',
        'quantity': '40 Kg',
        'amount': '₹1000',
        'location': 'Bharuch',
        'date': '11 Jun 2026',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        if (status == 'Delivered') { // Updated check
          return _buildCompletedCard(context, order);
        }

        return _buildStandardCard(context, order);
      },
    );
  }

  /// Card Design tailored to match image spec layout
  Widget _buildCompletedCard(BuildContext context, Map<String, String> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        // 3. Added Card Border
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60, // 4. Updated Product Icon Size
                  width: 60,  // 4. Updated Product Icon Size
                  decoration: BoxDecoration(
                    color: BuyerOrdersScreen.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.shopping_basket_rounded,
                    color: BuyerOrdersScreen.primaryColor,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['product']!,
                        style: const TextStyle(
                          fontSize: 16, // 5. Updated Product Name Size
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order['id']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Farmer: ${order['farmer']!}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusChip('Delivered'), // Updated status chip reference
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCompletedMetaColumn('Quantity', order['quantity']!, Alignment.centerLeft),
                _buildCompletedMetaColumn('Amount', order['amount']!, Alignment.center),
                _buildCompletedMetaColumn('Delivered', order['date']!, Alignment.centerRight),
              ],
            ),

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.deepPurple, width: 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        foregroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BuyerOrderDetailsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'View Details',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BuyerOrdersScreen.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductDetailsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Reorder',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedMetaColumn(String title, String value, AlignmentGeometry align) {
    return Column(
      crossAxisAlignment: align == Alignment.centerLeft
          ? CrossAxisAlignment.start
          : align == Alignment.centerRight
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: title == 'Amount' ? 18 : 15, // 6. Updated Amount size handling inside meta block
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  /// Standard card implementation for other tabs (Pending, Ongoing, Cancelled)
  Widget _buildStandardCard(BuildContext context, Map<String, String> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        // 3. Added Card Border
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60, // 4. Updated Product Icon Size
                  width: 60,  // 4. Updated Product Icon Size
                  decoration: BoxDecoration(
                    color: BuyerOrdersScreen.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.shopping_basket_rounded,
                    color: BuyerOrdersScreen.primaryColor,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['product']!,
                        style: const TextStyle(
                          fontSize: 16, // 5. Updated Product Name Size
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order['id']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Farmer: ${order['farmer']!}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusChip(status),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order['location']!,
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Quantity', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(order['quantity']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(order['date']!, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(
                      order['amount']!,
                      style: TextStyle(
                        fontSize: 18, // 6. Updated Amount Size
                        fontWeight: FontWeight.bold,
                        color: status == 'Cancelled' ? Colors.grey : BuyerOrdersScreen.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            if (status == 'Ongoing') ...[ // Updated conditional for ongoing progress indicator
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 0.65,
                  minHeight: 7,
                  color: BuyerOrdersScreen.primaryColor,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Placed', style: TextStyle(fontSize: 12)),
                  Text('Accepted', style: TextStyle(fontSize: 12)),
                  Text('In Transit', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: status == 'Cancelled' ? Colors.grey.shade300 : BuyerOrdersScreen.primaryColor,
                  foregroundColor: status == 'Cancelled' ? Colors.grey.shade800 : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  if (status == 'Cancelled' || status == 'Pending') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuyerOrderDetailsScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrackOrderScreen(),
                      ),
                    );
                  }
                },
                child: Text(
                  status == 'Cancelled' || status == 'Pending' ? 'View Details' : 'Track Order',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;
    String label = status;

    // 7. Updated internal conditional router
    switch (status) {
      case 'Pending':
        color = Colors.orange;
        break;
      case 'Ongoing':
        color = Colors.blue;
        label = 'In Progress';
        break;
      case 'Cancelled':
        color = Colors.red.shade700;
        break;
      case 'Delivered':
        color = Colors.green.shade700;
        label = 'Delivered';
        break;
      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12.5),
      ),
    );
  }
}

