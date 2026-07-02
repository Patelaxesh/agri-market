import 'package:agrimarket/features/admin/screens/admin_about_app_screen.dart';
import 'package:agrimarket/features/admin/screens/admin_change_password_screen.dart';
import 'package:agrimarket/features/admin/screens/admin_edit_profile_screen.dart';
import 'package:agrimarket/features/admin/screens/admin_help_support_screen.dart';
import 'package:agrimarket/features/admin/screens/admin_notifications_screen.dart';
import 'package:agrimarket/features/admin/screens/admin_reports_analytics_screen.dart';
import 'package:flutter/material.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF4F6F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Professional Header Panel
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 46,
                      backgroundColor: primaryColor.withValues(alpha: 0.1),
                      // Updated to withValues
                      child: const Icon(
                        Icons.admin_panel_settings_rounded,
                        size: 46,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Super Administrator',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'admin@agrimarket.com',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              /// Admin Stats Dashboard Grid
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.05,
                  children: [
                    _buildMetricBlock('Total Users', '205', Colors.blue),
                    _buildMetricBlock(
                      'Products',
                      '560',
                      Colors.orange.shade800,
                    ),
                    _buildMetricBlock('Orders', '240', Colors.purple),
                    _buildMetricBlock('Revenue', '₹1.25L', primaryColor),
                  ],
                ),
              ),

              /// Account Group
              _buildSectionHeader('Account'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildMenuRow(
                      Icons.person_outline_rounded,
                      'Edit Profile',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminEditProfileScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildMenuRow(
                      Icons.lock_open_rounded,
                      'Change Password',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// Platform Group
              _buildSectionHeader('Platform'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildMenuRow(
                      Icons.bar_chart_rounded,
                      'Reports & Analytics',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminReportsAnalyticsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildMenuRow(
                      Icons.notifications_none_rounded,
                      'Notifications',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminNotificationsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// Support Group
              _buildSectionHeader('Support'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildMenuRow(
                      Icons.help_outline_rounded,
                      'Help & Support',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminHelpSupportScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildMenuRow(Icons.info_outline_rounded, 'About App', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminAboutAppScreen(),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              /// Danger Zone Group
              _buildSectionHeader('Danger Zone'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _buildMenuRow(Icons.logout_rounded, 'Logout', () {
                  // Handle logout logic context operations here
                }, isDanger: true),
              ),

              /// Platform Meta Stamp
              const SizedBox(height: 32),
              Text(
                'AgreeMarket Admin',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade500,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildMetricBlock(String label, String val, Color metricColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            val,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: metricColor,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuRow(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDanger = false,
  }) {
    final Color elementColor = isDanger
        ? const Color(0xFFC62828)
        : Colors.black87;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDanger ? const Color(0xFFC62828) : primaryColor,
                size: 22,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isDanger ? FontWeight.bold : FontWeight.w600,
                    color: elementColor,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: isDanger
                    ? const Color(0xFFC62828).withValues(
                        alpha: 0.4,
                      ) // Updated to withValues
                    : Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: Colors.grey.shade100,
    );
  }
}
