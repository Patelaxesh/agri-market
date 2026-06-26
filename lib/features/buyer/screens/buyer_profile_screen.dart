import 'package:agrimarket/features/buyer/screens/buyer_edit_profile_screen.dart';
import 'package:agrimarket/features/buyer/screens/buyer_order_history_screen.dart';
import 'package:agrimarket/features/buyer/screens/help_support_screen.dart';
import 'package:agrimarket/features/buyer/screens/wishlist_screen.dart';
import 'package:agrimarket/features/legal/screens/privacy_policy_screen.dart';
import 'package:agrimarket/features/legal/screens/terms_conditions_screen.dart';
import 'package:flutter/material.dart';

class BuyerProfileScreen extends StatelessWidget {
  const BuyerProfileScreen({super.key});

  // Structural Color Definitions Matching Design Language
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textSubtle = Color(0xFF94A3B8);
  static const Color borderColor = Color(0xFFF1F5F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      // Modern clean off-white background
      body: CustomScrollView(
        slivers: [
          // Elegant & Compact Header Layout
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            elevation: 0,
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1B5E20), primaryColor],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Profile Image Frame
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.white24,
                                  shape: BoxShape.circle,
                                ),
                                child: const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.storefront_rounded,
                                    size: 40,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 14,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          // User Metadata
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Rajesh Traders",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "+91 9876543210",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.verified_user_rounded,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Verified Buyer",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Interactive Business Analytics Metrics Container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        _statCard(
                          "124",
                          "Total Orders",
                          Icons.shopping_bag_outlined,
                        ),
                        Container(height: 32, width: 1, color: borderColor),
                        _statCard(
                          "₹2.4L",
                          "Total Spent",
                          Icons.currency_rupee_rounded,
                        ),
                        Container(height: 32, width: 1, color: borderColor),
                        _statCard(
                          "15",
                          "Farmers Linked",
                          Icons.agriculture_rounded,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Account Operations Subsection Info Block
                _sectionTitle("Account Settings"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: _sectionBoxDecoration(),
                    child: Column(
                      children: [
                        _profileTile(
                          icon: Icons.person_outline_rounded,
                          title: "Edit Profile Info",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BuyerEditProfileScreen(),
                              ),
                            );
                          },
                        ),
                        _profileTile(
                          icon: Icons.location_on_outlined,
                          title: "Saved Delivery Addresses",
                          onTap: () {},
                        ),
                        _profileTile(
                          icon: Icons.notifications_none_rounded,
                          title: "Notification Configurations",
                          hasDivider: false,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Order Tracking Subsection Block
                _sectionTitle("My Activity"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: _sectionBoxDecoration(),
                    child: Column(
                      children: [
                        _profileTile(
                          icon: Icons.history_rounded,
                          title: "Purchase & Order History",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyerOrderHistoryScreen()));
                          },
                        ),
                        _profileTile(
                          icon: Icons.favorite_border_rounded,
                          title: "My Wishlist",
                          hasDivider: false,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WishlistScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Legal & Customer Care Subsection Info Block
                _sectionTitle("Support & Legal"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: _sectionBoxDecoration(),
                    child: Column(
                      children: [
                        _profileTile(
                          icon: Icons.support_agent_rounded,
                          title: "Help & Customer Support",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpSupportScreen(),
                              ),
                            );
                          },
                        ),
                        _profileTile(
                          icon: Icons.description_outlined,
                          title: "Terms & Conditions",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TermsConditionsScreen(),
                              ),
                            );
                          },
                        ),
                        _profileTile(
                          icon: Icons.privacy_tip_outlined,
                          title: "Privacy Policy Rules",
                          hasDivider: false,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicyScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Explicit System Logout Interactive Button Tile
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFEE2E2)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Color(0xFFEF4444),
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Logout Account",
                            style: TextStyle(
                              color: Color(0xFFEF4444),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "AgriMarket Platform v1.0.0",
                        style: TextStyle(
                          color: textSubtle,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Connecting Farmers & Buyers Globally",
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- UI Styling Helper Closures ---

  static BoxDecoration _sectionBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: borderColor),
    );
  }

  static Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: textSubtle,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  static Widget _statCard(String value, String title, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: textDark,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _profileTile({
    required IconData icon,
    required String title,
    bool hasDivider = true,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 12,
              leading: Icon(icon, color: textMuted, size: 22),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: Color(0xFF334155),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: Color(0xFFCBD5E1),
              ),
            ),
            if (hasDivider) const Divider(height: 1, color: borderColor),
          ],
        ),
      ),
    );
  }
}
