
import 'package:flutter/material.dart';

class AdminHelpSupportScreen extends StatelessWidget {
const AdminHelpSupportScreen({super.key});

static const Color primaryColor = Color(0xFF2E7D32);
static const Color backgroundColor = Color(0xFFF5F7F5);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: backgroundColor,
appBar: AppBar(
backgroundColor: Colors.white,
foregroundColor: Colors.black87,
elevation: 0,
title: const Text(
'Help & Support',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 22,
),
),
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
children: [
/// Header Card
Container(
width: double.infinity,
padding: const EdgeInsets.all(24),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [
primaryColor,
Color(0xFF1B5E20),
],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
borderRadius: BorderRadius.circular(24),
),
child: const Column(
children: [
CircleAvatar(
radius: 40,
backgroundColor: Colors.white,
child: Icon(
Icons.support_agent,
size: 40,
color: primaryColor,
),
),
SizedBox(height: 12),
Text(
'Need Help?',
style: TextStyle(
color: Colors.white,
fontSize: 24,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 4),
Text(
'We are here to help you.',
style: TextStyle(
color: Colors.white70,
),
),
],
),
),

const SizedBox(height: 20),

/// Contact Support
_supportCard(
icon: Icons.email_outlined,
title: 'Email Support',
subtitle: 'support@agrimarket.com',
),

const SizedBox(height: 12),

_supportCard(
icon: Icons.phone_outlined,
title: 'Call Support',
subtitle: '+91 98765 43210',
),

const SizedBox(height: 12),

_supportCard(
icon: Icons.chat_outlined,
title: 'Live Chat',
subtitle: 'Chat with our support team',
),

const SizedBox(height: 20),

/// FAQ Section
Container(
width: double.infinity,
padding: const EdgeInsets.all(18),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
),
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Frequently Asked Questions',
style: TextStyle(
fontSize: 17,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 16),

ExpansionTile(
tilePadding: EdgeInsets.zero,
title: Text('How do I approve a farmer?'),
children: [
Padding(
padding: EdgeInsets.all(12),
child: Text(
'Go to Users screen and review the farmer profile before approving.',
),
),
],
),

ExpansionTile(
tilePadding: EdgeInsets.zero,
title: Text('How do I manage products?'),
children: [
Padding(
padding: EdgeInsets.all(12),
child: Text(
'Open Products screen to approve, reject, or review product listings.',
),
),
],
),

ExpansionTile(
tilePadding: EdgeInsets.zero,
title: Text('How can I track orders?'),
children: [
Padding(
padding: EdgeInsets.all(12),
child: Text(
'Visit the Orders section to view pending, active, and completed orders.',
),
),
],
),
],
),
),

const SizedBox(height: 24),

const Text(
'AgriMarket Admin Support',
style: TextStyle(
color: Colors.grey,
fontSize: 13,
),
),
],
),
),
);
}

Widget _supportCard({
required IconData icon,
required String title,
required String subtitle,
}) {
return Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(18),
),
child: Row(
children: [
CircleAvatar(
backgroundColor: primaryColor.withOpacity(0.1),
child: Icon(
icon,
color: primaryColor,
),
),
const SizedBox(width: 14),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
title,
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 4),
Text(
subtitle,
style: const TextStyle(
color: Colors.grey,
),
),
],
),
),
const Icon(
Icons.arrow_forward_ios,
size: 16,
color: Colors.grey,
),
],
),
);
}
}

