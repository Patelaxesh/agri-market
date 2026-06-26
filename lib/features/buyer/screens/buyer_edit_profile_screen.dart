import 'package:flutter/material.dart';

class BuyerEditProfileScreen extends StatefulWidget {
  const BuyerEditProfileScreen({super.key});

  @override
  State<BuyerEditProfileScreen> createState() => _BuyerEditProfileScreenState();
}

class _BuyerEditProfileScreenState extends State<BuyerEditProfileScreen> {
  // Global Design Language Theme Settings
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textSubtle = Color(0xFF94A3B8);
  static const Color borderColor = Color(0xFFF1F5F9);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController businessNameController = TextEditingController(
    text: "Rajesh Traders",
  );

  final TextEditingController ownerNameController = TextEditingController(
    text: "Rajesh Patel",
  );

  final TextEditingController mobileController = TextEditingController(
    text: "9876543210",
  );

  final TextEditingController emailController = TextEditingController(
    text: "rajesh@gmail.com",
  );

  final TextEditingController gstController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final TextEditingController cityController = TextEditingController(
    text: "Surat",
  );

  final TextEditingController stateController = TextEditingController(
    text: "Gujarat",
  );

  final TextEditingController pincodeController = TextEditingController();

  String businessType = "Vegetable Vendor";

  final List<String> businessTypes = [
    "Vegetable Vendor",
    "Fruit Vendor",
    "Restaurant",
    "Hotel",
    "Wholesaler",
    "Retail Shop",
    "Caterer",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Modern crisp light slate gray canvas

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: textDark, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: textDark,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  children: [
                    /// Profile Image Frame Layout
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: borderColor,
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 46,
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
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: primaryColor,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    _buildField(
                      controller: businessNameController,
                      label: "Business Name",
                      icon: Icons.store_rounded,
                    ),

                    const SizedBox(height: 14),

                    _buildField(
                      controller: ownerNameController,
                      label: "Owner Name",
                      icon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 14),

                    _buildField(
                      controller: mobileController,
                      label: "Mobile Number",
                      icon: Icons.phone_android_rounded,
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 14),

                    _buildField(
                      controller: emailController,
                      label: "Email Address",
                      icon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 14),

                    /// Dropdown Component matching exact field boundaries
                    DropdownButtonFormField<String>(
                      initialValue: businessType,
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: textDark, fontSize: 13.5, fontWeight: FontWeight.w600),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: textSubtle, size: 20),
                      decoration: _inputDecoration(label: "Business Type", icon: Icons.business_center_outlined),
                      items: businessTypes
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          businessType = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    _buildField(
                      controller: gstController,
                      label: "GST Number (Optional)",
                      icon: Icons.receipt_long_rounded,
                    ),

                    const SizedBox(height: 14),

                    _buildField(
                      controller: addressController,
                      label: "Address",
                      icon: Icons.location_on_outlined,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            controller: cityController,
                            label: "City",
                            icon: Icons.location_city_rounded,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            controller: stateController,
                            label: "State",
                            icon: Icons.map_outlined,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    _buildField(
                      controller: pincodeController,
                      label: "Pincode",
                      icon: Icons.pin_drop_outlined,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),

            /// Flexible Viewport Footer keeping control structures grounded
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Profile updates saved successfully'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: textDark,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Layout Helper Specifications ---

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: textDark, fontSize: 13.5, fontWeight: FontWeight.w600),
      decoration: _inputDecoration(label: label, icon: icon),
    );
  }

  InputDecoration _inputDecoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: textMuted, fontSize: 12.5, fontWeight: FontWeight.w500),
      floatingLabelStyle: const TextStyle(color: primaryColor, fontSize: 12.5, fontWeight: FontWeight.bold),
      prefixIcon: Icon(icon, color: textSubtle, size: 18),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 1.2),
      ),
    );
  }
}