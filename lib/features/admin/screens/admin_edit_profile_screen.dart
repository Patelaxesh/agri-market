import 'package:flutter/material.dart';

class AdminEditProfileScreen extends StatelessWidget {
  const AdminEditProfileScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Stack(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 55,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.edit,
                      color: primaryColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildField(
              label: 'Full Name',
              hint: 'Admin',
              icon: Icons.person_outline,
            ),

            const SizedBox(height: 16),

            _buildField(
              label: 'Email Address',
              hint: 'admin@agrimarket.com',
              icon: Icons.email_outlined,
            ),

            const SizedBox(height: 16),

            _buildField(
              label: 'Phone Number',
              hint: '+91 9876543210',
              icon: Icons.phone_outlined,
            ),

            const SizedBox(height: 16),

            _buildField(
              label: 'Role',
              hint: 'Super Administrator',
              icon: Icons.admin_panel_settings_outlined,
            ),

            const SizedBox(height: 16),

            _buildField(
              label: 'Joined Date',
              hint: '12 June 2026',
              icon: Icons.calendar_month_outlined,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: hint,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}