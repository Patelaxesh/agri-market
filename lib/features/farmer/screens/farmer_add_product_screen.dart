import 'package:flutter/material.dart';

class FarmerAddProductScreen extends StatefulWidget {
  const FarmerAddProductScreen({super.key});

  @override
  State<FarmerAddProductScreen> createState() =>
      _FarmerAddProductScreenState();
}

class _FarmerAddProductScreenState
    extends State<FarmerAddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController productNameController =
  TextEditingController();

  final TextEditingController priceController =
  TextEditingController();

  final TextEditingController quantityController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  String selectedCategory = 'Vegetables';

  final List<String> categories = [
    'Vegetables',
    'Fruits',
    'Grains',
    'Pulses',
    'Dairy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Product',
          style: TextStyle(
            color: Color(0xFF1B5E20),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF1B5E20),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// Product Image
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    // Pick Image
                  },
                  child: const Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 50,
                        color: Color(0xFF2E7D32),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Upload Product Image',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Product Name
              TextFormField(
                controller:
                productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: const Icon(
                    Icons.inventory_2_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Enter product name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Category
              DropdownButtonFormField(
                initialValue: selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  prefixIcon:
                  const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory =
                        value.toString();
                  });
                },
              ),

              const SizedBox(height: 16),

              /// Price
              TextFormField(
                controller: priceController,
                keyboardType:
                TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price (₹/kg)',
                  prefixIcon:
                  const Icon(Icons.currency_rupee),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Enter price';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Quantity
              TextFormField(
                controller: quantityController,
                keyboardType:
                TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity (kg)',
                  prefixIcon:
                  const Icon(Icons.scale),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Enter quantity';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Description
              TextFormField(
                controller:
                descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// Post Product Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!
                        .validate()) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Product Added Successfully',
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Post Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}