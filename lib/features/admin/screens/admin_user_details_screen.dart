import 'package:flutter/material.dart';

class AdminUserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const AdminUserDetailsScreen({super.key, required this.userData});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF4F6F4);

  @override
  Widget build(BuildContext context) {
    final String name = userData['name'] ?? 'User';
    final String status = userData['status'] ?? 'Pending';
    final String initial = name.isNotEmpty ? name[0] : '?';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text('User Details', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Profile Badge Base Header Card Panel
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: primaryColor.withValues(alpha: 0.1),
                    child: Text(initial, style: const TextStyle(color: primaryColor, fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  Text(userData['role'] ?? 'Member', style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.w500, fontSize: 14)),
                  const SizedBox(height: 12),
                  _buildStatusBadge(status),
                ],
              ),
            ),
            const SizedBox(height: 16),

            /// Information Parameters Group Matrix Card Blocks
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Profile Information', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider()),
                  _infoRowDetail('Phone Number', userData['phone'] ?? 'N/A'),
                  _infoRowDetail('Address Info', userData['address'] ?? 'N/A'),
                  _infoRowDetail('Join Timestamp', userData['joinDate'] ?? 'N/A'),
                  _infoRowDetail('Products Listed', userData['products'] ?? '0 Items'),
                  _infoRowDetail('Orders Fulfilled', userData['orders'] ?? '0 Orders'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// Dynamic Bottom Action Row Toolbar
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 18),
                    label: const Text('Back'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      side: BorderSide(color: Colors.grey.shade200, width: 1.5),
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: status == 'Pending' ? primaryColor : const Color(0xFFC62828),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: Text(status == 'Pending' ? 'Approve User' : (status == 'Blocked' ? 'Unblock User' : 'Block User')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRowDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500))),
          Expanded(flex: 3, child: Text(value, style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color baseColor = status == 'Verified' ? const Color(0xFF2E7D32) : (status == 'Pending' ? Colors.orange.shade800 : const Color(0xFFC62828));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(color: baseColor.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(20)),
      child: Text(status, style: TextStyle(color: baseColor, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}