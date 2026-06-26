import 'package:flutter/material.dart';
import 'auth_text_fields.dart';

class BuyerFields extends StatelessWidget {
  final TextEditingController businessNameController;
  final TextEditingController cityController;
  final String selectedBuyerType;
  final ValueChanged<String?> onBuyerTypeChanged;

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color fieldColor = Color(0xFFF3F6F3);

  const BuyerFields({
    super.key,
    required this.businessNameController,
    required this.cityController,
    required this.selectedBuyerType,
    required this.onBuyerTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Business Information',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 16),

        AuthTextFields(
          controller: businessNameController,
          hintText: 'Business Name',
          icon: Icons.business_outlined,
        ),

        const SizedBox(height: 16),

        DropdownButtonFormField<String>(
          initialValue: selectedBuyerType,
          decoration: InputDecoration(
            labelText: 'Buyer Type',
            prefixIcon: const Icon(
              Icons.storefront_outlined,
              color: primaryColor,
            ),
            filled: true,
            fillColor: fieldColor,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: primaryColor, width: 1.5),
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Vendor', child: Text('Vendor')),
            DropdownMenuItem(
              value: 'Grocery Store',
              child: Text('Grocery Store'),
            ),
            DropdownMenuItem(value: 'Restaurant', child: Text('Restaurant')),
            DropdownMenuItem(value: 'Hotel', child: Text('Hotel')),
            DropdownMenuItem(value: 'Caterer', child: Text('Caterer')),
            DropdownMenuItem(value: 'Wholesaler', child: Text('Wholesaler')),
          ],
          onChanged: onBuyerTypeChanged,
        ),

        const SizedBox(height: 16),

        AuthTextFields(
          controller: cityController,
          hintText: 'City',
          icon: Icons.location_city_outlined,
        ),
      ],
    );
  }
}
