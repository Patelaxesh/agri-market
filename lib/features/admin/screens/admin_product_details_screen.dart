import 'package:flutter/material.dart';

class AdminProductDetailsScreen extends StatelessWidget {
  final Map<String, String> productData;

  const AdminProductDetailsScreen({super.key, required this.productData});

  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF4F6F4);

  @override
  Widget build(BuildContext context) {
    final String name = productData['name'] ?? 'Product';
    final String status = productData['status'] ?? 'Pending';
    final String initial = name.isNotEmpty ? name[0] : '?';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 1. Profile Badge Base Header Card Panel (Mirrors User Screen Layout)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: primaryColor.withValues(alpha: 0.1),
                    child: Text(
                      initial,
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    productData['category'] ?? 'General',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildStatusBadge(status),
                ],
              ),
            ),
            const SizedBox(height: 16),

            /// 2. Information Parameters Group Matrix Card Blocks (Using Clean Side-by-Side Rows)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Product Information',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  _infoRowDetail('Farmer Name', productData['farmer'] ?? 'N/A'),
                  _infoRowDetail('Target Price', productData['price'] ?? 'N/A'),
                  _infoRowDetail('Stock Available', productData['quantity'] ?? '100 kg'),
                  _infoRowDetail('Added Date', productData['addedDate'] ?? '19 Jun 2026'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// 3. Dynamic Bottom Action Row Toolbar (Adapts perfectly to specific state workflows)
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
                  child: _buildContextActionButton(status),
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
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color baseColor;
    switch (status) {
      case 'Approved':
        baseColor = const Color(0xFF2E7D32);
        break;
      case 'Pending':
        baseColor = Colors.orange.shade800;
        break;
      default:
        baseColor = const Color(0xFFC62828);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: baseColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContextActionButton(String status) {
    Color btnBgColor;
    String btnText;

    if (status == 'Pending') {
      btnBgColor = primaryColor;
      btnText = 'Approve Product';
    } else if (status == 'Rejected') {
      btnBgColor = const Color(0xFF1565C0); // Premium blue hue for restore flows
      btnText = 'Restore Product';
    } else {
      btnBgColor = const Color(0xFFC62828);
      btnText = 'Reject Product';
    }

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: btnBgColor,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: Text(btnText),
    );
  }
}