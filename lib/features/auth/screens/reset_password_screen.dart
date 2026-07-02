import 'dart:async';

import 'package:agrimarket/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with TickerProviderStateMixin {
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF8FAF8);
  static const Color fieldColor = Color(0xFFF4F7F4);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Animation Core Parameters
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  bool _isUpdating = false;
  bool _isSuccess = false;
  bool _isButtonPressed = false;

  // Live Password Validation Trackers
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumeric = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    passwordController.addListener(_validatePasswordMetrics);
    confirmPasswordController.addListener(
      () => setState(() {}),
    ); // Re-evaluate matches live

    _entranceController.forward();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _validatePasswordMetrics() {
    final text = passwordController.text;
    setState(() {
      _hasMinLength = text.length >= 8;
      _hasUppercase = text.contains(RegExp(r'[A-Z]'));
      _hasNumeric = text.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  double _calculateStrength() {
    double score = 0.0;
    if (_hasMinLength) score += 0.25;
    if (_hasUppercase) score += 0.25;
    if (_hasNumeric) score += 0.25;
    if (_hasSpecialChar) score += 0.25;
    return score;
  }

  Color _getStrengthColor(double strength) {
    if (strength <= 0.25) return Colors.redAccent;
    if (strength <= 0.75) return Colors.orangeAccent;
    return primaryColor;
  }

  String _getStrengthText(double strength) {
    if (strength == 0.0) return 'None';
    if (strength <= 0.25) return 'Weak';
    if (strength <= 0.75) return 'Medium';
    return 'Strong';
  }

  bool get _doPasswordsMatch {
    return passwordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate() ||
        _calculateStrength() < 1.0 ||
        !_doPasswordsMatch) {
      HapticFeedback.vibrate();
      return;
    }

    _passwordFocusNode.unfocus();
    _confirmPasswordFocusNode.unfocus();

    setState(() {
      _isUpdating = true;
    });

    // Premium processing UX artificial window
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    setState(() {
      _isUpdating = false;
      _isSuccess = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    // Flush back through stack cleanly into updated Login context
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 750),
        pageBuilder: (_, _, _) => const LoginScreen(),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.02, end: 1.0).animate(animation),
            child: child,
          ),
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strength = _calculateStrength();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'assets/images/agrimarket_logo.png',
                            height: 90,
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          'Create a Secure Password',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your new password should be unique and difficult to guess.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.withValues(
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 28),

                        /// Form Surface Card Layer
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// 1. New Password Input
                                TextFormField(
                                  controller: passwordController,
                                  focusNode: _passwordFocusNode,
                                  obscureText: _obscurePassword,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'New Password',
                                    prefixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                      color: primaryColor,
                                      size: 22,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () => setState(
                                        () => _obscurePassword =
                                            !_obscurePassword,
                                      ),
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        size: 20,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: fieldColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                /// 2. Dynamic Strength Indicator Matrix Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: strength == 0.0
                                            ? 0.03
                                            : strength,
                                        backgroundColor: Colors.grey.shade200,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              _getStrengthColor(strength),
                                            ),
                                        minHeight: 6,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      _getStrengthText(strength),
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: _getStrengthColor(strength),
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                /// 3. Active Real-time Requirement List Components
                                _buildRequirementRow(
                                  'Minimum 8 characters',
                                  _hasMinLength,
                                  theme,
                                ),
                                _buildRequirementRow(
                                  'One uppercase letter (A-Z)',
                                  _hasUppercase,
                                  theme,
                                ),
                                _buildRequirementRow(
                                  'One numeric value (0-9)',
                                  _hasNumeric,
                                  theme,
                                ),
                                _buildRequirementRow(
                                  'One special symbol (@, #)',
                                  _hasSpecialChar,
                                  theme,
                                ),

                                const Divider(height: 32, thickness: 1),

                                /// 4. Confirm Password Input
                                TextFormField(
                                  controller: confirmPasswordController,
                                  focusNode: _confirmPasswordFocusNode,
                                  obscureText: _obscureConfirmPassword,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Confirm New Password',
                                    prefixIcon: const Icon(
                                      Icons.lock_clock_outlined,
                                      color: primaryColor,
                                      size: 22,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () => setState(
                                        () => _obscureConfirmPassword =
                                            !_obscureConfirmPassword,
                                      ),
                                      icon: Icon(
                                        _obscureConfirmPassword
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        size: 20,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: fieldColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                /// 5. Live Interactive Passwords Match Sub-Label
                                if (confirmPasswordController
                                    .text
                                    .isNotEmpty) ...[
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        _doPasswordsMatch
                                            ? Icons.check_circle_outline_rounded
                                            : Icons.highlight_off_rounded,
                                        color: _doPasswordsMatch
                                            ? primaryColor
                                            : Colors.redAccent,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        _doPasswordsMatch
                                            ? 'Passwords match'
                                            : "Passwords don't match",
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: _doPasswordsMatch
                                                  ? primaryColor
                                                  : Colors.redAccent,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 28),

                                /// 6. Material 3 Action Button Stack Wrapper
                                AnimatedScale(
                                  scale: _isButtonPressed ? 0.97 : 1.0,
                                  duration: const Duration(milliseconds: 100),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 54,
                                    child: FilledButton(
                                      onPressed:
                                          (_isUpdating ||
                                              _isSuccess ||
                                              strength < 1.0 ||
                                              !_doPasswordsMatch)
                                          ? null
                                          : () {
                                              setState(
                                                () => _isButtonPressed = true,
                                              );
                                              Future.delayed(
                                                const Duration(
                                                  milliseconds: 100,
                                                ),
                                                () {
                                                  if (mounted) {
                                                    setState(() {
                                                      _isButtonPressed = false;
                                                    });
                                                  }
                                                },
                                              );
                                              _updatePassword();
                                            },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      ),
                                      child: AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        child: _isSuccess
                                            ? const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Colors.white,
                                                    size: 22,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    'Password Updated',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : _isUpdating
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2.5,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(Colors.white),
                                                ),
                                              )
                                            : Text(
                                                'Update Password',
                                                style: theme
                                                    .textTheme
                                                    .labelLarge
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                      ),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool satisfied, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Icon(
            satisfied
                ? Icons.check_rounded
                : Icons.radio_button_unchecked_rounded,
            color: satisfied ? primaryColor : Colors.black26,
            size: 15,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: satisfied ? Colors.black87 : Colors.black45,
                fontWeight: satisfied ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on TextStyle? {
  TextStyle? withValues({required Color color}) {
    return null;
  }
}
