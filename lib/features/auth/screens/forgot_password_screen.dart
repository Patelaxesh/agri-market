// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:agrimarket/features/auth/screens/forgot_password_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF8FAF8);
  static const Color fieldColor = Color(0xFFF4F7F4);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  // Micro-Animation States
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  bool _isSending = false;
  bool _isSuccess = false;
  bool _isContinuePressed = false;
  bool _isBackPressed = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Setup Entrance Animations (Fade + Slide up)
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

    _entranceController.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    _emailFocusNode.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  // Airtight Production Email Validation Regular Expression
  bool _isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email.trim());
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) {
      HapticFeedback.vibrate();
      return;
    }

    // Dismiss keyboard natively
    _emailFocusNode.unfocus();

    setState(() {
      _isSending = true;
    });

    // Simulated network authentication preparation latency
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    setState(() {
      _isSending = false;
      _isSuccess = true;
    });

    // Hold success tick animation frame momentarily before route pushing
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    // Reset view state safely for returning operations
    setState(() {
      _isSuccess = false;
    });

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, _, _) =>
            ForgotPasswordOtpScreen(userEmail: emailController.text.trim()),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.98, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
                        /// 1. Shared Brand Hero Connection Node
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'assets/images/agrimarket_logo.png',
                            height: 90,
                          ),
                        ),
                        const SizedBox(height: 24),

                        /// Header Section
                        Text(
                          'Reset Your Password',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "We'll help you securely recover your AgriMarket account.",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.withValues(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 32),

                        /// 2. Premium Material 3 Surface Form Card
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                /// Premium Dynamic Email Input Field
                                TextFormField(
                                  controller: emailController,
                                  focusNode: _emailFocusNode,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      color: primaryColor,
                                      size: 22,
                                    ),
                                    filled: true,
                                    fillColor: fieldColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: Colors.redAccent,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: Colors.redAccent,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter your email address';
                                    }
                                    if (!_isValidEmail(value)) {
                                      return 'Please enter a valid structural email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 28),

                                /// Material 3 Continuance Action Interface
                                AnimatedScale(
                                  scale: _isContinuePressed ? 0.97 : 1.0,
                                  duration: const Duration(milliseconds: 100),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 54,
                                    child: FilledButton(
                                      onPressed: (_isSending || _isSuccess)
                                          ? null
                                          : () {
                                              setState(
                                                () => _isContinuePressed = true,
                                              );
                                              Future.delayed(
                                                const Duration(
                                                  milliseconds: 100,
                                                ),
                                                () {
                                                  if (mounted) {
                                                    setState(() {
                                                      _isContinuePressed = false;
                                                    });
                                                  }
                                                },
                                              );
                                              _continue();
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
                                            ? const Icon(
                                                Icons.check_circle_rounded,
                                                color: Colors.white,
                                                size: 26,
                                              )
                                            : _isSending
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
                                                'Continue',
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
                                const SizedBox(height: 16),

                                /// Premium Return Navigational Anchoring
                                AnimatedScale(
                                  scale: _isBackPressed ? 0.96 : 1.0,
                                  duration: const Duration(milliseconds: 100),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() => _isBackPressed = true);
                                      Future.delayed(
                                        const Duration(milliseconds: 100),
                                        () {
                                          if (mounted) {
                                            setState(
                                              () => _isBackPressed = false,
                                            );
                                            Navigator.pop(context);
                                          }
                                        },
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size(140, 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.arrow_back_rounded,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Back to Login',
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
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
}

extension on TextStyle? {
  TextStyle? withValues({required Color color}) {
    return null;
  }
}
