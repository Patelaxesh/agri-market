import 'dart:async';

import 'package:agrimarket/features/auth/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  final String userEmail;

  const ForgotPasswordOtpScreen({
    super.key,
    this.userEmail = 'ax***@gmail.com',
  });

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen>
    with TickerProviderStateMixin {
  static const Color primaryColor = Color(0xFF2E7D32);

  // 1. Core State Matrix
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  // 2. Structural Animation Handlers
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  Timer? _countdownTimer;
  int _secondsRemaining = 30;
  bool _isResendAvailable = false;
  bool _isVerifying = false;
  bool _isSuccess = false;
  String? _inlineError;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());

    // Shake Animation Pipeline Configurations
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 12.0,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);

    // Staggered Entrance Setup
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    _startTimer();
    _entranceController.forward();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 30;
      _isResendAvailable = false;
    });
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _isResendAvailable = true;
          _countdownTimer?.cancel();
        });
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _shakeController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  String get _currentOtpString => _controllers.map((c) => c.text).join();

  Future<void> _handleOtpVerification() async {
    final otp = _currentOtpString;
    if (otp.length < 6) {
      setState(() => _inlineError = 'Please enter all 6 verification digits.');
      _triggerShakeEffect();
      return;
    }

    setState(() {
      _isVerifying = true;
      _inlineError = null;
    });

    // Mock network call delay
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    if (otp == '123456') {
      setState(() {
        _isVerifying = false;
        _isSuccess = true;
      });
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, _, _) => const ResetPasswordScreen(),
          transitionsBuilder: (_, animation, _, child) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.97, end: 1.0).animate(animation),
              child: child,
            ),
          ),
        ),
      );
    } else {
      setState(() {
        _isVerifying = false;
        _inlineError = 'Invalid verification code. Please check and try again.';
      });
      _triggerShakeEffect();
    }
  }

  void _triggerShakeEffect() {
    _shakeController.forward(from: 0.0);
    HapticFeedback.vibrate();
  }

  void _onBoxChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _handleOtpVerification(); // Auto-verify on final box input completion
      }
    }
  }

  void _onRawKeyHandling(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _controllers[index - 1].clear();
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
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
                        'Verify Your Identity',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text.rich(
                        TextSpan(
                          text: "We've sent a 6-digit verification code to\n",
                          style: theme.textTheme.bodyMedium?.withValues(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: widget.userEmail,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      /// Premium Container Card
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
                              /// Corrected Animated Localized Shake Segment
                              AnimatedBuilder(
                                animation: _shakeAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      _shakeController.isAnimating
                                          ? (_shakeController.value *
                                                        100 ~/
                                                        1 %
                                                        2 ==
                                                    0
                                                ? _shakeAnimation.value
                                                : -_shakeAnimation.value)
                                          : 0.0,
                                      0,
                                    ),
                                    child: child,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    6,
                                    (index) => _buildOtpInputBox(index),
                                  ),
                                ),
                              ),

                              if (_inlineError != null) ...[
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.redAccent,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        _inlineError!,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 28),

                              /// Resend Timer Configuration Array
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isResendAvailable
                                        ? "Didn't receive code? "
                                        : "Resend code in ",
                                    style: theme.textTheme.bodyMedium
                                        ?.withValues(color: Colors.black54),
                                  ),
                                  _isResendAvailable
                                      ? GestureDetector(
                                          onTap: () {
                                            _startTimer();
                                            setState(() => _inlineError = null);
                                          },
                                          child: const Text(
                                            'Resend Code',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                                          style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(height: 28),

                              /// Material 3 Verify Execution Button Block
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: FilledButton(
                                  onPressed: (_isVerifying || _isSuccess)
                                      ? null
                                      : _handleOtpVerification,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: _isSuccess
                                        ? TweenAnimationBuilder<double>(
                                            tween: Tween<double>(
                                              begin: 0.0,
                                              end: 1.0,
                                            ),
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            builder: (_, val, _) =>
                                                Transform.scale(
                                                  scale: val,
                                                  child: const Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Colors.white,
                                                    size: 26,
                                                  ),
                                                ),
                                          )
                                        : _isVerifying
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          )
                                        : Text(
                                            'Verify Code',
                                            style: theme.textTheme.labelLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
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
    );
  }

  /// Segmented Individual Field Box Node (Corrected Layout Alignment Parameters)
  Widget _buildOtpInputBox(int index) {
    return SizedBox(
      width: 48,
      height: 56,
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) => _onRawKeyHandling(event, index),
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: const Color(0xFFF4F7F4),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor, width: 2),
            ),
          ),
          onChanged: (value) => _onBoxChanged(value, index),
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
