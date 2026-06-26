import 'package:flutter/material.dart';

class AccountTypeSelector extends StatelessWidget {
  final bool isFarmer;
  final ValueChanged<bool> onChanged;

  static const Color primaryColor = Color(0xFF2E7D32);

  const AccountTypeSelector({
    super.key,
    required this.isFarmer,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account Type',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _buildCard(
                title: 'Farmer',
                icon: Icons.agriculture,
                isSelected: isFarmer,
                onTap: () => onChanged(true),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _buildCard(
                title: 'Buyer',
                icon: Icons.storefront_outlined,
                isSelected: !isFarmer,
                onTap: () => onChanged(false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 90,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : const Color(0xFFF3F6F3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected ? Colors.white : primaryColor,
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
