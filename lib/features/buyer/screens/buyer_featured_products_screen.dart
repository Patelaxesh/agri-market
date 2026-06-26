
import 'package:agrimarket/features/buyer/screens/buyer_product_details_screen.dart';
import 'package:flutter/material.dart';

class BuyerFeaturedProductsScreen extends StatefulWidget {
const BuyerFeaturedProductsScreen({super.key});

@override
State<BuyerFeaturedProductsScreen> createState() => _BuyerFeaturedProductsScreenState();
}

class _BuyerFeaturedProductsScreenState extends State<BuyerFeaturedProductsScreen> {
String selectedFilter = 'All';
String searchQuery = '';
final TextEditingController _searchController = TextEditingController();

final List<String> filters = [
'All',
'Vegetables',
'Fruits',
'Grains',
'Spices',
];

final List<Map<String, dynamic>> allProducts = [
{
'productName': 'Fresh Tomatoes',
'farmerName': 'Ramesh Patel',
'location': 'Bharuch',
'price': '₹28/kg',
'quantity': '500 Kg',
'category': 'Vegetables',
},
{
'productName': 'Organic Potatoes',
'farmerName': 'Suresh Bhai',
'location': 'Ankleshwar',
'price': '₹24/kg',
'quantity': '1 Ton',
'category': 'Vegetables',
},
{
'productName': 'Alfonso Mangoes',
'farmerName': 'Arvind Shah',
'location': 'Valsad',
'price': '₹120/kg',
'quantity': '200 Kg',
'category': 'Fruits',
},
{
'productName': 'Premium Wheat',
'farmerName': 'Jayesh Kumar',
'location': 'Bardoli',
'price': '₹32/kg',
'quantity': '5 Tons',
'category': 'Grains',
},
{
'productName': 'Fresh Green Chillies',
'farmerName': 'Ramesh Patel',
'location': 'Bharuch',
'price': '₹45/kg',
'quantity': '150 Kg',
'category': 'Spices',
},
{
'productName': 'Sweet Bananas',
'farmerName': 'Suresh Bhai',
'location': 'Ankleshwar',
'price': '₹40/dozen',
'quantity': '300 Dozen',
'category': 'Fruits',
},
];

@override
void dispose() {
_searchController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
// Filter logic
final filteredProducts = allProducts.where((product) {
final matchesCategory =
selectedFilter == 'All' || product['category'] == selectedFilter;
final matchesSearch =
product['productName']!.toLowerCase().contains(
searchQuery.toLowerCase(),
) ||
product['farmerName']!.toLowerCase().contains(
searchQuery.toLowerCase(),
);
return matchesCategory && matchesSearch;
}).toList();

return Scaffold(
backgroundColor: const Color(0xFFF8FAFC),
appBar: AppBar(
backgroundColor: Colors.white,
elevation: 0,
scrolledUnderElevation: 0,
surfaceTintColor: Colors.transparent,
leading: Padding(
padding: const EdgeInsets.only(left: 10),
child: IconButton(
icon: const Icon(
Icons.arrow_back_ios_new_rounded,
color: Color(0xFF1E293B),
size: 18,
),
onPressed: () => Navigator.pop(context),
),
),
title: const Text(
'Featured Marketplace',
style: TextStyle(
color: Color(0xFF1E293B),
fontWeight: FontWeight.w800,
fontSize: 19,
letterSpacing: -0.3,
),
),
centerTitle: true,
),
body: Column(
children: [
// Search & Filter Panel
Container(
width: double.infinity,
color: Colors.white,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Padding(
padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
child: Container(
decoration: BoxDecoration(
color: const Color(0xFFF1F5F9),
borderRadius: BorderRadius.circular(16),
),
child: TextField(
controller: _searchController,
onChanged: (value) {
setState(() {
searchQuery = value;
});
},
style: const TextStyle(
color: Color(0xFF1E293B),
fontSize: 14,
),
decoration: InputDecoration(
hintText: 'Search items, categories, or farmers...',
hintStyle: const TextStyle(
color: Color(0xFF94A3B8),
fontSize: 14,
),
prefixIcon: const Icon(
Icons.search_rounded,
color: Color(0xFF2E7D32),
size: 22,
),
suffixIcon: searchQuery.isNotEmpty
? GestureDetector(
onTap: () {
setState(() {
_searchController.clear();
searchQuery = '';
});
},
child: const Icon(
Icons.cancel_rounded,
color: Color(0xFF94A3B8),
size: 20,
),
)
    : null,
border: InputBorder.none,
contentPadding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 14,
),
),
),
),
),

// Filters
SizedBox(
height: 48,
child: ListView.builder(
scrollDirection: Axis.horizontal,
physics: const BouncingScrollPhysics(),
padding: const EdgeInsets.symmetric(horizontal: 20),
itemCount: filters.length,
itemBuilder: (context, index) {
final isSelected = selectedFilter == filters[index];
return Padding(
padding: const EdgeInsets.only(right: 8, bottom: 10),
child: GestureDetector(
onTap: () {
setState(() {
selectedFilter = filters[index];
});
},
child: Container(
padding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 6,
),
decoration: BoxDecoration(
color: isSelected
? const Color(0xFF2E7D32)
    : const Color(0xFFF1F5F9),
borderRadius: BorderRadius.circular(12),
),
child: Center(
child: Text(
filters[index],
style: TextStyle(
color: isSelected
? Colors.white
    : const Color(0xFF64748B),
fontWeight: isSelected
? FontWeight.bold
    : FontWeight.w500,
fontSize: 13,
),
),
),
),
),
);
},
),
),
],
),
),

// Horizontal-style List Items Display
Expanded(
child: filteredProducts.isEmpty
? _buildEmptyState()
    : ListView.builder(
padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
physics: const BouncingScrollPhysics(),
itemCount: filteredProducts.length,
itemBuilder: (context, index) {
final item = filteredProducts[index];
return _HorizontalProductRowCard(item: item);
},
),
),
],
),
);
}

Widget _buildEmptyState() {
return Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.green.withValues(alpha: 0.04), // Updated to withValues
shape: BoxShape.circle,
),
child: const Icon(
Icons.search_off_rounded,
size: 50,
color: Color(0xFF94A3B8),
),
),
const SizedBox(height: 14),
const Text(
'No products match your adjustments',
style: TextStyle(
color: Color(0xFF1E293B),
fontSize: 15,
fontWeight: FontWeight.w600,
),
),
const SizedBox(height: 4),
const Text(
'Try modifying keywords or filter options',
style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
),
],
),
);
}
}

// Beautiful Custom Horizontal Product Row Card Component
class _HorizontalProductRowCard extends StatelessWidget {
final Map<String, dynamic> item;

const _HorizontalProductRowCard({required this.item});

@override
Widget build(BuildContext context) {
const Color primaryColor = Color(0xFF2E7D32);

return Container(
margin: const EdgeInsets.only(bottom: 14),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(20),
boxShadow: [
BoxShadow(
color: Colors.black.withValues(alpha: 0.04), // Updated to withValues
blurRadius: 12,
offset: const Offset(0, 4),
),
],
),
child: InkWell(
borderRadius: BorderRadius.circular(20),
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const BuyerProductDetailsScreen(),
),
);
},
child: Padding(
padding: const EdgeInsets.all(12),
child: Row(
children: [
// 1. Left Aspect: Image Thumb Container
Container(
height: 100,
width: 100,
decoration: BoxDecoration(
color: Colors.green.shade50,
borderRadius: BorderRadius.circular(16),
),
child: const Icon(
Icons.eco_rounded,
size: 44,
color: primaryColor,
),
),
const SizedBox(width: 14),

// 2. Right Aspect: Complete Content Column
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// Title and Price info row
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(
child: Text(
item['productName'],
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
color: Color(0xFF1E293B),
),
),
),
Text(
item['price'],
style: const TextStyle(
color: primaryColor,
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
],
),
const SizedBox(height: 4),

// Farmer Subtitle Row
Row(
children: [
const Icon(
Icons.person_outline_rounded,
size: 14,
color: primaryColor,
),
const SizedBox(width: 4),
Text(
item['farmerName'],
style: TextStyle(
color: Colors.grey.shade600,
fontSize: 13,
),
),
],
),
const SizedBox(height: 4),

// Location Info Row
Row(
children: [
Icon(
Icons.location_on_outlined,
size: 14,
color: Colors.grey.shade400,
),
const SizedBox(width: 4),
Text(
item['location'],
style: TextStyle(
color: Colors.grey.shade500,
fontSize: 12,
),
),
],
),
const SizedBox(height: 10),

// Stock/Available Status Badge indicator
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Container(
padding: const EdgeInsets.symmetric(
horizontal: 8,
vertical: 4,
),
decoration: BoxDecoration(
color: Colors.green.shade50,
borderRadius: BorderRadius.circular(8),
),
child: Text(
'Stock: ${item['quantity']}',
style: const TextStyle(
color: primaryColor,
fontSize: 11,
fontWeight: FontWeight.bold,
),
),
),
// Tiny forward action context hint button
Icon(
Icons.arrow_forward_ios_rounded,
size: 12,
color: Colors.grey.shade400,
),
],
),
],
),
),
],
),
),
),
);
}
}

