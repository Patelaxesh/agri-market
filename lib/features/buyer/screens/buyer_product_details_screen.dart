import 'package:agrimarket/features/buyer/screens/buyer_cart_screen.dart';
import 'package:agrimarket/features/buyer/screens/buyer_checkout_screen.dart';
import 'package:flutter/material.dart';

class BuyerProductDetailsScreen extends StatefulWidget {
  const BuyerProductDetailsScreen({super.key});

  @override
  State<BuyerProductDetailsScreen> createState() =>
      _BuyerProductDetailsScreenState();
}

class _BuyerProductDetailsScreenState extends State<BuyerProductDetailsScreen> {
  static const int pricePerKg = 30;
  static const int minOrderQty = 20;

  int quantity = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.green.shade100,
              child: const Center(
                child: Icon(
                  Icons.shopping_basket,
                  size: 120,
                  color: Colors.green,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Name
                  const Text(
                    'Fresh Tomato',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  /// Rating & Location
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.location_on, color: Colors.red, size: 20),
                      SizedBox(width: 4),
                      Text('Surat'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Farmer Card
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(radius: 25, child: Icon(Icons.person)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rahul Patel',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '⭐ 4.8 • 12 Products',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '📍 Surat, Gujarat',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Price
                  const Text(
                    '₹30 / kg',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Updated Stock Section
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Stock: 500 Kg',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Minimum Order: 20 Kg',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Product Details Card
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Category'), Text('Vegetables')],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Organic'), Text('Yes')],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Harvest Date'), Text('14 Jun 2026')],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Quantity Selector
                  const Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > minOrderQty) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.remove_circle,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                      Text(
                        '$quantity kg',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Total Price
                  Text(
                    'Total: ₹${quantity * pricePerKg}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Fresh organic tomatoes harvested directly from local farms. Rich in nutrients, naturally grown, and delivered fresh to vendors.',
                    style: TextStyle(height: 1.5, color: Colors.black87),
                  ),

                  const SizedBox(height: 30),

                  /// Updated Bottom Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Go to Cart Screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BuyerCartScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart_outlined),
                          label: const Text('Add To Cart'),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 55),
                            side: const BorderSide(color: Color(0xFF2E7D32)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Buy Now - Direct to Checkout
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BuyerCheckoutScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            minimumSize: const Size(0, 55),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Buy Now'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
