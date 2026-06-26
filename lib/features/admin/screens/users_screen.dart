import 'package:agrimarket/features/admin/screens/admin_user_details_screen.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF4F6F4);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                elevation: 0,
                pinned: true,
                floating: true,
                centerTitle: false,
                title: const Text(
                  'Users',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 22,
                  ),
                ),
                // Height bumped to 72 to perfectly resolve the RenderFlex layout overflow
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(72),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.grey.shade600,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      tabs: const [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.agriculture_rounded, size: 18),
                              SizedBox(width: 8),
                              Text('Farmers (120)'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.storefront_rounded, size: 18),
                              SizedBox(width: 8),
                              Text('Vendors (85)'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              UsersList(userType: 'Farmer'),
              UsersList(userType: 'Vendor'),
            ],
          ),
        ),
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  final String userType;
  const UsersList({super.key, required this.userType});

  static const Color primaryColor = Color(0xFF2E7D32);

  @override
  Widget build(BuildContext context) {
    // Empty state mock data tester: Change to true to verify the empty status panel
    const bool testEmptyState = false;

    final users = testEmptyState
        ? <Map<String, String>>[]
        : userType == 'Farmer'
        ? [
      {'name': 'Rahul Patel', 'phone': '+91 9876543210', 'location': 'Surat', 'status': 'Verified', 'joinDate': '12 Jun 2026'},
      {'name': 'Amit Sharma', 'phone': '+91 9876543211', 'location': 'Ahmedabad', 'status': 'Pending', 'joinDate': '18 Jun 2026'},
      {'name': 'Jay Patel', 'phone': '+91 9876543212', 'location': 'Vadodara', 'status': 'Verified', 'joinDate': '05 May 2026'},
      {'name': 'Kiran Kumar', 'phone': '+91 9876543213', 'location': 'Rajkot', 'status': 'Blocked', 'joinDate': '11 Apr 2026'},
    ]
         : [
    {'name': 'Ramesh Shah', 'phone': '+91 9123456789', 'location': 'Surat', 'status': 'Verified', 'joinDate': '14 Jun 2026'},
    {'name': 'Hardik Mehta', 'phone': '+91 9123456780', 'location': 'Anand', 'status': 'Pending', 'joinDate': '19 Jun 2026'},
    {'name': 'Vijay Kirpa', 'phone': '+91 9123456781', 'location': 'Rajkot', 'status': 'Blocked', 'joinDate': '01 Jan 2026'}, // Fixed here
    ];

    return Column(
      children: [
        /// Clean Status Metrics Grid Row Overview
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.1,
            children: userType == 'Farmer'
                ? [
              _tabSummaryBlock('Total', '120', Colors.blue),
              _tabSummaryBlock('Verified', '100', Colors.green),
              _tabSummaryBlock('Pending', '15', Colors.orange),
              _tabSummaryBlock('Blocked', '5', Colors.red),
            ]
                : [
              _tabSummaryBlock('Total', '85', Colors.blue),
              _tabSummaryBlock('Verified', '70', Colors.green),
              _tabSummaryBlock('Pending', '10', Colors.orange),
              _tabSummaryBlock('Blocked', '5', Colors.red),
            ],
          ),
        ),

        /// Sticky Search Strip Panel Layout Block
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search $userType profile...',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.tune_rounded, color: primaryColor, size: 22),
              ),
            ],
          ),
        ),

        /// User Directory Scrollable Feed stream list
        Expanded(
          child: users.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final String name = user['name']!;
              final String status = user['status']!;
              final String initial = name.isNotEmpty ? name[0] : '?';

              void navigateToDetails() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminUserDetailsScreen(
                      userData: {
                        ...user,
                        'role': userType,
                        'address': '${user['location']}, Gujarat, India',
                        'products': userType == 'Farmer' ? '14 Items' : 'N/A',
                        'orders': '48 Orders',
                      },
                    ),
                  ),
                );
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.015), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: navigateToDetails, // Entire profile card is responsive to touches
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: primaryColor.withOpacity(0.1),
                                child: Text(
                                  initial,
                                  style: const TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            name,
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                                          ),
                                        ),
                                        _buildStatusChip(status),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    _iconDetailLabel(Icons.phone_outlined, user['phone']!),
                                    const SizedBox(height: 4),
                                    _iconDetailLabel(Icons.location_on_outlined, user['location']!),
                                    const SizedBox(height: 4),
                                    _iconDetailLabel(Icons.calendar_today_outlined, 'Joined ${user['joinDate']}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: navigateToDetails,
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(0, 42),
                                    side: BorderSide(color: Colors.grey.shade200, width: 1.5),
                                    foregroundColor: Colors.black87,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                  child: const Text('View Profile'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildActionButton(status),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _tabSummaryBlock(String title, String val, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(val, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(title, style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _iconDetailLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey.shade500),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      ],
    );
  }

  Widget _buildActionButton(String status) {
    final bool isPending = status == 'Pending';
    final bool isBlocked = status == 'Blocked';

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isPending ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
        foregroundColor: isPending ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
        elevation: 0,
        minimumSize: const Size(0, 42),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
      child: Text(isPending ? 'Approve' : (isBlocked ? 'Unblock' : 'Block')),
    );
  }

  Widget _buildStatusChip(String status) {
    Color baseColor;
    switch (status) {
      case 'Verified':
        baseColor = const Color(0xFF2E7D32);
        break;
      case 'Pending':
        baseColor = Colors.orange.shade800;
        break;
      default:
        baseColor = const Color(0xFFC62828);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: baseColor.withOpacity(0.08), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(color: baseColor, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                userType == 'Farmer' ? Icons.agriculture_outlined : Icons.storefront_outlined,
                size: 48,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No ${userType.toLowerCase()}s found',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            Text(
              'Start by approving new account registrations.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}