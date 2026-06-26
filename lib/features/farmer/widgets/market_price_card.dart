import 'package:flutter/material.dart';

class MarketPriceCard extends StatelessWidget {
  final String cropName;
  final String price;

  const MarketPriceCard({
    super.key,
    required this.cropName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE8F5E9),
          child: Icon(
            Icons.grass,
            color: Color(0xFF2E7D32),
          ),
        ),
        title: Text(
          cropName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}