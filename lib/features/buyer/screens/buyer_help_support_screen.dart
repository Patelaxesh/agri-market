
import 'package:flutter/material.dart';

class BuyerHelpSupportScreen extends StatelessWidget {
const BuyerHelpSupportScreen({super.key});

static const Color primaryColor = Color(0xFF2E7D32);

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF8FAFC),
appBar: AppBar(
backgroundColor: const Color(0xFFF8FAFC),
elevation: 0,
scrolledUnderElevation: 0,
iconTheme: const IconThemeData(color: Colors.black),
title: const Text(
'Help & Support',
style: TextStyle(
color: Colors.black,
fontWeight: FontWeight.bold,
fontSize: 20,
),
),
),
body: SingleChildScrollView(
physics: const BouncingScrollPhysics(),
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// Header Hero Box
Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(24),
boxShadow: [
BoxShadow(
color: Colors.black.withValues(alpha: 0.04), // Updated to withValues
blurRadius: 16,
offset: const Offset(0, 4),
),
],
),
child: Column(
children: [
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: primaryColor.withValues(alpha: 0.08), // Updated to withValues
shape: BoxShape.circle,
),
child: const Icon(
Icons.support_agent_rounded,
size: 46,
color: primaryColor,
),
),
const SizedBox(height: 20),
const Text(
"How Can We Help You?",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
letterSpacing: -0.5,
),
),
const SizedBox(height: 10),
Text(
"Our support ecosystem is here to assist you with any questions or operational hurdles.",
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.grey.shade600,
height: 1.5,
fontSize: 14,
),
),
],
),
),

const SizedBox(height: 28),

// Quick Contact Header
const Text(
"Quick Connect",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
letterSpacing: -0.3,
),
),
const SizedBox(height: 12),

// Contact Options
_contactOption(
icon: Icons.phone_forwarded_rounded,
title: "Call Us Direct",
subtitle: "+91 98765 43210",
onTap: () {},
),
_contactOption(
icon: Icons.alternate_email_rounded,
title: "Email Support Desk",
subtitle: "support@agrimarket.com",
onTap: () {},
),
_contactOption(
icon: Icons.forum_rounded,
title: "Live Chat Support",
subtitle: "Available Daily: 9 AM - 7 PM",
onTap: () {},
),

const SizedBox(height: 28),

// FAQ Section Header
const Text(
"Frequently Asked Questions",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
letterSpacing: -0.3,
),
),

const SizedBox(height: 12),

// FAQ Grid / List
_faqItem(
question: "How do I place an order?",
answer:
"Browse products, add to cart, and proceed to checkout. You can pay via Cash on Delivery, UPI, or Bank Transfer securely.",
),
_faqItem(
question: "What are the delivery charges?",
answer:
"Delivery charges are flat ₹100 for orders below ₹2000. Enjoy completely free delivery on all orders above ₹2000.",
),
_faqItem(
question: "How can I track my active order?",
answer:
"Go to your Profile > My Orders > Active tab. You can view real-time log-updates and delivery courier assignments.",
),
_faqItem(
question: "What is the marketplace return policy?",
answer:
"Returns are accepted within 24 hours of delivery if the harvest product arrives damaged or isn't as described by the seller.",
),
_faqItem(
question: "How do I become a verified farmer?",
answer:
"Go to your Profile > Become a Seller, fill out your field layouts, and upload relevant registration documents for quick verification.",
),
_faqItem(
question: "I forgot my password, what should I do?",
answer:
"On the entry authentication screen, tap 'Forgot Password' and follow the instant setup steps via SMS/Email OTP code.",
),

const SizedBox(height: 28),

// Still Need Help Dynamic Card
Container(
padding: const EdgeInsets.all(24),
decoration: BoxDecoration(
gradient: LinearGradient(
colors: [primaryColor, primaryColor.withBlue(50)],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
borderRadius: BorderRadius.circular(24),
boxShadow: [
BoxShadow(
color: primaryColor.withValues(alpha: 0.2), // Updated to withValues
blurRadius: 16,
offset: const Offset(0, 6),
),
],
),
child: Column(
children: [
const Text(
"Still Need Help?",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
const SizedBox(height: 6),
Text(
"Can't find what you need? Open a support ticket instantly.",
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.white.withValues(alpha: 0.85), // Updated to withValues
fontSize: 13,
),
),
const SizedBox(height: 20),
ElevatedButton.icon(
onPressed: () {},
icon: const Icon(Icons.maps_ugc_rounded, size: 20),
label: const Text(
"Contact Helpdesk",
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 15,
),
),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.white,
foregroundColor: primaryColor,
elevation: 0,
minimumSize: const Size(double.infinity, 54),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
),
),
],
),
),

const SizedBox(height: 40),

// App Meta Styling
Center(
child: Column(
children: [
Text(
"AgriMarket Ecosystem v1.0.0",
style: TextStyle(
color: Colors.grey.shade500,
fontWeight: FontWeight.bold,
fontSize: 13,
),
),
const SizedBox(height: 4),
Text(
"Connecting Farmers & Buyers Transparently",
style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
),
],
),
),

const SizedBox(height: 40),
],
),
),
);
}

Widget _contactOption({
required IconData icon,
required String title,
required String subtitle,
required VoidCallback onTap,
}) {
return Container(
margin: const EdgeInsets.only(bottom: 12),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
border: Border.all(color: Colors.grey.shade100, width: 1.5),
boxShadow: [
BoxShadow(
color: Colors.black.withValues(alpha: 0.02), // Updated to withValues
blurRadius: 10,
offset: const Offset(0, 4),
),
],
),
child: ListTile(
contentPadding: const EdgeInsets.symmetric(
horizontal: 20,
vertical: 12,
),
leading: Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: primaryColor.withValues(alpha: 0.08), // Updated to withValues
borderRadius: BorderRadius.circular(14),
),
child: Icon(icon, color: primaryColor, size: 22),
),
title: Text(
title,
style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
),
subtitle: Padding(
padding: const EdgeInsets.only(top: 4),
child: Text(
subtitle,
style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
),
),
trailing: Container(
padding: const EdgeInsets.all(6),
decoration: BoxDecoration(
color: Colors.grey.shade50,
shape: BoxShape.circle,
),
child: Icon(
Icons.arrow_forward_ios_rounded,
size: 14,
color: Colors.grey.shade400,
),
),
onTap: onTap,
),
);
}

Widget _faqItem({required String question, required String answer}) {
return Container(
margin: const EdgeInsets.only(bottom: 12),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
border: Border.all(color: Colors.grey.shade100, width: 1.5),
boxShadow: [
BoxShadow(
color: Colors.black.withValues(alpha: 0.02), // Maintained withValues here
blurRadius: 8,
offset: const Offset(0, 3),
),
],
),
child: Theme(
data: ThemeData().copyWith(dividerColor: Colors.transparent),
child: ExpansionTile(
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20),
),
collapsedShape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(20),
),
iconColor: primaryColor,
collapsedIconColor: Colors.grey.shade400,
tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
title: Text(
question,
style: const TextStyle(
fontSize: 15,
fontWeight: FontWeight.w600,
color: Colors.black,
),
),
children: [
Padding(
padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
child: Text(
answer,
style: TextStyle(
color: Colors.grey.shade600,
height: 1.6,
fontSize: 14,
),
),
),
],
),
),
);
}
}

