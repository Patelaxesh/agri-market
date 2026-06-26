import 'package:flutter/material.dart';
import 'auth_text_fields.dart';

class FarmerFields extends StatelessWidget {
  final TextEditingController villageController;
  final TextEditingController stateController;

  const FarmerFields({
    super.key,
    required this.villageController,
    required this.stateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Farmer Information',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 16),

        AuthTextFields(
          controller: villageController,
          hintText: 'Village / City',
          icon: Icons.location_city_outlined,
        ),

        const SizedBox(height: 16),

        AuthTextFields(
          controller: stateController,
          hintText: 'State',
          icon: Icons.map_outlined,
        ),
      ],
    );
  }
}
