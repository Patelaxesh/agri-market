import 'dart:ui';

// Assuming architectural package imports exist in your design framework
import 'package:agrimarket/features/auth/models/registration_model.dart';
import 'package:agrimarket/features/auth/providers/auth_provider.dart';
import 'package:agrimarket/features/auth/screens/otp_verification_screen.dart';
import 'package:agrimarket/features/legal/screens/privacy_policy_screen.dart';
import 'package:agrimarket/features/legal/screens/terms_conditions_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  // --- Centralized App Theme Settings ---
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color accentColor = Color(0xFFE8F5E9);
  static const double fieldBorderRadius = 16.0;
  static const Color fieldFillColor = Color(0xFFF4F7F4);

  final _formKey = GlobalKey<FormState>();

  bool isFarmer = true;
  bool agreeTerms = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool _passwordFieldHasFocus = false;

  // Form Field Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Focus Nodes for Dynamic Layout Adaptations
  final FocusNode _passwordFocusNode = FocusNode();

  // Password Strength Parameters
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  double _passwordStrength = 0.0;
  String _passwordStrengthText = '';
  Color _passwordStrengthColor = Colors.grey;
  bool _passwordsMatch = false;

  // Tap Gesture Recognizers for Legal Links
  late TapGestureRecognizer _termsRecognizer;
  late TapGestureRecognizer _privacyRecognizer;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();

    passwordController.addListener(_evaluatePasswordRules);
    confirmPasswordController.addListener(_checkPasswordMatch);

    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordFieldHasFocus = _passwordFocusNode.hasFocus;
      });
    });

    _termsRecognizer = TapGestureRecognizer()..onTap = _handleTermsTap;
    _privacyRecognizer = TapGestureRecognizer()..onTap = _handlePrivacyTap;
  }

  @override
  void dispose() {
    passwordController.removeListener(_evaluatePasswordRules);
    confirmPasswordController.removeListener(_checkPasswordMatch);
    _passwordFocusNode.dispose();
    fullNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _animationController.dispose();
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  void _handleTermsTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TermsConditionsScreen()),
    );
  }

  void _handlePrivacyTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
    );
  }

  void _evaluatePasswordRules() {
    final pass = passwordController.text;

    setState(() {
      _hasMinLength = pass.length >= 8;
      _hasUppercase = RegExp(r'(?=.*[A-Z])').hasMatch(pass);
      _hasNumber = RegExp(r'(?=.*[0-9])').hasMatch(pass);
      _hasSpecialChar = RegExp(r'(?=.*[!@#\$&*~])').hasMatch(pass);

      double strength = 0.0;
      if (pass.isNotEmpty) {
        if (pass.length >= 6) strength += 0.2;
        if (_hasMinLength) strength += 0.2;
        if (_hasUppercase) strength += 0.2;
        if (_hasNumber) strength += 0.2;
        if (_hasSpecialChar) strength += 0.2;
      }

      _passwordStrength = strength.clamp(0.0, 1.0);
      if (_passwordStrength == 0.0) {
        _passwordStrengthText = '';
        _passwordStrengthColor = Colors.grey;
      } else if (_passwordStrength <= 0.2) {
        _passwordStrengthText = 'Weak';
        _passwordStrengthColor = Colors.redAccent;
      } else if (_passwordStrength <= 0.4) {
        _passwordStrengthText = 'Fair';
        _passwordStrengthColor = Colors.orangeAccent;
      } else if (_passwordStrength <= 0.6) {
        _passwordStrengthText = 'Good';
        _passwordStrengthColor = Colors.blueAccent;
      } else if (_passwordStrength <= 0.8) {
        _passwordStrengthText = 'Strong';
        _passwordStrengthColor = Colors.lightGreen;
      } else {
        _passwordStrengthText = 'Excellent';
        _passwordStrengthColor = primaryColor;
      }
    });
    _checkPasswordMatch();
  }

  void _checkPasswordMatch() {
    setState(() {
      _passwordsMatch =
          passwordController.text.isNotEmpty &&
          passwordController.text == confirmPasswordController.text;
    });
  }

  void _submitSignup() {
    if (!_formKey.currentState!.validate()) return;

    if (!agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the Terms & Conditions and Privacy Policy to proceed.',
          ),
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }

    TextInput.finishAutofillContext();

    final signupParams = RegistrationModel(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      mobile: mobileController.text.trim(),
      role: isFarmer ? 'farmer' : 'buyer',
    );

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider.sendOtp(
      phoneNumber: signupParams.mobile,
      onCodeSent: (verificationId) {
        debugPrint("OTP SENT");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white),
                SizedBox(width: 12),
                Text('OTP sent successfully.'),
              ],
            ),
            backgroundColor: primaryColor,
            duration: Duration(milliseconds: 1500),
          ),
        );

        Future.delayed(const Duration(milliseconds: 400), () {
          if (!mounted) return;
          debugPrint("NAVIGATING TO OTP SCREEN");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtpVerificationScreen(registrationData: signupParams),
            ),
          );
        });
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

  InputDecoration _getInputDecoration(
    String label,
    IconData icon, {
    String? hintText,
    Widget? prefixWidget,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIcon: prefixWidget == null
          ? Icon(icon, color: Colors.grey.shade600)
          : null,
      prefix: prefixWidget,
      labelStyle: const TextStyle(color: Colors.black54),
      floatingLabelStyle: const TextStyle(color: primaryColor),
      filled: true,
      fillColor: fieldFillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isUiBusy = authProvider.isLoading;
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFEBF2EC), Color(0xFFF4F8F5), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Positioned(
            top: -50,
            right: -50,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: accentColor.withAlpha(100),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -60,
            child: CircleAvatar(
              radius: 140,
              backgroundColor: accentColor.withAlpha(76),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: isTablet ? 40 : 24,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isTablet ? 560 : 480),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: AutofillGroup(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 12),
                              _buildHeader(isTablet),
                              SizedBox(height: isTablet ? 40 : 30),
                              Card(
                                elevation: 4,
                                shadowColor: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                color: Colors.white.withAlpha(230),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      _buildFullNameField(isUiBusy),
                                      const SizedBox(height: 16),
                                      _buildMobileField(isUiBusy),
                                      const SizedBox(height: 16),
                                      _buildEmailField(isUiBusy),
                                      const SizedBox(height: 16),
                                      _buildPasswordField(isUiBusy),
                                      _buildPasswordStrengthIndicator(),
                                      const SizedBox(height: 16),
                                      _buildConfirmPasswordField(isUiBusy),
                                      const SizedBox(height: 24),
                                      _buildRoleSelector(isUiBusy),
                                      const SizedBox(height: 24),
                                      _buildTermsAndConditionsRow(isUiBusy),
                                      const SizedBox(height: 24),
                                      _buildContinueButton(isUiBusy),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildFooter(isUiBusy),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (isUiBusy)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Colors.black.withAlpha(64),
                  child: Center(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28.0,
                          vertical: 24.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                primaryColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Creating Account...',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isTablet) {
    return Semantics(
      label: 'AgriMarket Registration Onboarding Header',
      container: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Join AgriMarket to buy and sell fresh produce.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Hero(
            tag: 'agrimarket_logo_hero',
            child: Image.asset(
              'assets/images/agrimarket_logo.png',
              height: isTablet ? 76.0 : 64.0,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.eco_rounded,
                size: isTablet ? 64 : 48,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullNameField(bool isUiBusy) {
    return TextFormField(
      controller: fullNameController,
      enabled: !isUiBusy,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      style: const TextStyle(fontSize: 15),
      decoration: _getInputDecoration(
        'Full Name',
        Icons.person_outline_rounded,
      ),
      validator: (val) => (val == null || val.trim().isEmpty)
          ? 'Please enter your full name'
          : null,
    );
  }

  Widget _buildMobileField(bool isUiBusy) {
    return TextFormField(
      controller: mobileController,
      enabled: !isUiBusy,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      style: const TextStyle(fontSize: 15, letterSpacing: 1.0),
      decoration: _getInputDecoration(
        'Mobile Number',
        Icons.phone_android_rounded,
        hintText: '9876543210',
        prefixWidget: Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone_android_rounded, color: Colors.grey.shade600),
              const SizedBox(width: 12),
              const Text(
                '+91',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              Container(height: 18, width: 1, color: Colors.grey.shade400),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.trim().isEmpty) {
          return 'Please enter your mobile number';
        }
        if (val.trim().length != 10) {
          return 'Mobile number must be exactly 10 digits';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField(bool isUiBusy) {
    return TextFormField(
      controller: emailController,
      enabled: !isUiBusy,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      style: const TextStyle(fontSize: 15),
      decoration: _getInputDecoration(
        'Email Address',
        Icons.mail_outline_rounded,
      ),
      validator: (val) {
        if (val == null || val.trim().isEmpty) {
          return 'Please enter your email address';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val.trim())) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(bool isUiBusy) {
    return TextFormField(
      controller: passwordController,
      focusNode: _passwordFocusNode,
      enabled: !isUiBusy,
      obscureText: obscurePassword,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.newPassword],
      style: const TextStyle(fontSize: 15),
      decoration: _getInputDecoration('Password', Icons.lock_outline_rounded)
          .copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: () =>
                  setState(() => obscurePassword = !obscurePassword),
            ),
          ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter password';
        }
        if (val.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    if (!_passwordFieldHasFocus && passwordController.text.isEmpty) {
      return const SizedBox.shrink();
    }
    if (passwordController.text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: _passwordStrength,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _passwordStrengthColor,
                ),
                minHeight: 4,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _passwordStrengthText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _passwordStrengthColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPasswordField(bool isUiBusy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: confirmPasswordController,
          enabled: !isUiBusy,
          obscureText: obscureConfirmPassword,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.newPassword],
          style: const TextStyle(fontSize: 15),
          decoration:
              _getInputDecoration(
                'Confirm Password',
                Icons.lock_reset_rounded,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(
                    () => obscureConfirmPassword = !obscureConfirmPassword,
                  ),
                ),
              ),
          onFieldSubmitted: (_) => _submitSignup(),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Please re-enter your password';
            }
            if (val != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        if (confirmPasswordController.text.isNotEmpty) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Row(
              children: [
                Icon(
                  _passwordsMatch
                      ? Icons.check_circle_rounded
                      : Icons.error_outline_rounded,
                  size: 14,
                  color: _passwordsMatch ? primaryColor : Colors.redAccent,
                ),
                const SizedBox(width: 6),
                Text(
                  _passwordsMatch
                      ? 'Passwords match'
                      : 'Passwords do not match',
                  style: TextStyle(
                    fontSize: 12,
                    color: _passwordsMatch ? primaryColor : Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRoleSelector(bool isUiBusy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildRoleCard(
                title: 'Farmer',
                icon: Icons.agriculture_rounded,
                isSelected: isFarmer,
                onTap: isUiBusy ? null : () => setState(() => isFarmer = true),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildRoleCard(
                title: 'Buyer',
                icon: Icons.shopping_cart_outlined,
                isSelected: !isFarmer,
                onTap: isUiBusy ? null : () => setState(() => isFarmer = false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: isSelected ? primaryColor : Colors.grey),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? primaryColor : Colors.black87,
                  ),
                ),
              ],
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: isSelected
                  ? const Icon(
                      Icons.check_circle,
                      key: ValueKey('selected_check'),
                      size: 18,
                      color: primaryColor,
                    )
                  : const SizedBox(
                      key: ValueKey('unselected_blank'),
                      width: 18,
                      height: 18,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsAndConditionsRow(bool isUiBusy) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: agreeTerms,
              activeColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: isUiBusy
                  ? null
                  : (val) => setState(() => agreeTerms = val ?? false),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I agree to the ',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: 'Terms & Conditions',
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: _termsRecognizer,
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: _privacyRecognizer,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(bool isUiBusy) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: isUiBusy
            ? null
            : [
                BoxShadow(
                  color: primaryColor.withAlpha(60),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
        gradient: isUiBusy
            ? null
            : const LinearGradient(
                colors: [primaryColor, Color(0xFF1B5E20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: isUiBusy ? null : _submitSignup,
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(bool isUiBusy) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        TextButton(
          onPressed: isUiBusy
              ? null
              : () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
