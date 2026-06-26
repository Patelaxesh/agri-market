import 'package:agrimarket/features/auth/screens/otp_verification_screen.dart';
import 'package:agrimarket/features/auth/models/registration_params.dart';
import 'package:agrimarket/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/account_type_selector.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/buyer_fields.dart';
import '../widgets/farmer_fields.dart';
import '../widgets/password_text_field.dart';
import '../widgets/terms_checkbox.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isFarmer = true;
  bool agreeTerms = false;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String selectedBuyerType = 'Vendor';

  @override
  void dispose() {
    fullNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    villageController.dispose();
    stateController.dispose();
    businessNameController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _verifyMobileNumber() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (mobileController.text.trim().length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 10-digit mobile number')),
      );
      return;
    }

    if (!emailController.text.trim().contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid email address')),
      );
      return;
    }

    if (fullNameController.text.trim().isEmpty ||
        mobileController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    if (isFarmer) {
      if (villageController.text.trim().isEmpty ||
          stateController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete farmer details')),
        );
        return;
      }
    } else {
      if (businessNameController.text.trim().isEmpty ||
          cityController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete buyer details')),
        );
        return;
      }
    }

    if (!agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept Terms & Conditions')),
      );
      return;
    }

    final signupParams = RegistrationParams(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      mobile: mobileController.text.trim(),
      role: isFarmer ? 'farmer' : 'buyer',
      village: isFarmer ? villageController.text.trim() : null,
      state: isFarmer ? stateController.text.trim() : null,
      businessName: !isFarmer ? businessNameController.text.trim() : null,
      city: !isFarmer ? cityController.text.trim() : null,
      buyerType: !isFarmer ? selectedBuyerType : null,
    );

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Call dynamic SMS delivery before opening the OTP validation layout
    authProvider.sendOtp(
      phoneNumber: signupParams.mobile,
      onCodeSent: (verificationId) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(registrationData: signupParams),
          ),
        );
      },
      onVerificationFailed: (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.redAccent,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/agrimarket_logo.png',
                        height: 110,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Connect directly with trusted buyers and farmers',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                AuthTextField(
                  controller: fullNameController,
                  hintText: 'Full Name',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: mobileController,
                  hintText: 'Mobile Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                PasswordTextField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(height: 16),
                PasswordTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                ),
                const SizedBox(height: 24),
                AccountTypeSelector(
                  isFarmer: isFarmer,
                  onChanged: (value) {
                    setState(() {
                      isFarmer = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (isFarmer)
                  FarmerFields(
                    villageController: villageController,
                    stateController: stateController,
                  )
                else
                  BuyerFields(
                    businessNameController: businessNameController,
                    cityController: cityController,
                    selectedBuyerType: selectedBuyerType,
                    onBuyerTypeChanged: (value) {
                      setState(() {
                        selectedBuyerType = value ?? 'Vendor';
                      });
                    },
                  ),
                const SizedBox(height: 20),
                TermsCheckbox(
                  value: agreeTerms,
                  onChanged: (value) {
                    setState(() {
                      agreeTerms = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                authProvider.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
                )
                    : AuthButton(
                  text: 'Verify Mobile Number',
                  onPressed: _verifyMobileNumber,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}