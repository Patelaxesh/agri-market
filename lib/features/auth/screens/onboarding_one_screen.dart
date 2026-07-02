import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agrimarket/features/auth/screens/login_screen.dart';
import 'package:agrimarket/features/auth/screens/onboarding_two_screen.dart';

class OnboardingOneScreen extends StatefulWidget {
  const OnboardingOneScreen({super.key});

  @override
  State<OnboardingOneScreen> createState() => _OnboardingOneScreenState();
}

class _OnboardingOneScreenState extends State<OnboardingOneScreen> with TickerProviderStateMixin {
  late final AnimationController _cardController;
  late final Animation<double> _cardFadeAnimation;
  late final Animation<Offset> _cardSlideAnimation;

  bool _isNextLoading = false;
  bool _isSkipPressed = false;
  bool _isNextPressed = false;

  @override
  void initState() {
    super.initState();

    // 1. Enforce Status Bar Configuration consistency
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // 2. Setup Entrance Animations (Fade + Slide + Scale feel)
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _cardFadeAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOut,
    );

    _cardSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOutCubic,
    ));

    // Stagger presentation slightly behind background render pipeline
    unawaited(
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) _cardController.forward();
      }),
    );
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  // Helper Custom Page Routing Method for Cross-fading Scaling Effects
  void _navigateToRoute(Widget destination) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650),
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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

    // 3. Lock Navigation Controls out completely
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            /// Background Artwork Context with Ken Burns Animation loop
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.06, end: 1.0),
              duration: const Duration(seconds: 4),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/onboarding_1.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),

            /// Foreground Layout Structure Core
            SafeArea(
              top: true,
              bottom: true,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate responsive width parameters safely
                  final isMobile = constraints.maxWidth < 600;
                  final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
                  final buttonWidth = isMobile ? 160.0 : (isTablet ? 180.0 : 220.0);

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /// Staggered Glass Control Card
                            SlideTransition(
                              position: _cardSlideAnimation,
                              child: FadeTransition(
                                opacity: _cardFadeAnimation,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                    child: Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: .18),
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: .3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: .08),
                                            blurRadius: 25,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          /// Premium Capsule Progress Indicators Array
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              _buildCapsuleIndicator(true, theme),
                                              _buildCapsuleIndicator(false, theme),
                                              _buildCapsuleIndicator(false, theme),
                                            ],
                                          ),

                                          const SizedBox(height: 32),

                                          /// Action Controls Row Pipeline
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              /// Material 3 Skip Button with Touch Interaction Scaling
                                              AnimatedScale(
                                                scale: _isSkipPressed ? 0.96 : 1.0,
                                                duration: const Duration(milliseconds: 100),
                                                child: FilledButton.tonal(
                                                  onPressed: _isNextLoading
                                                      ? null
                                                      : () {
                                                    setState(() => _isSkipPressed = true);
                                                    Future.delayed(const Duration(milliseconds: 100), () {
                                                      if (mounted) {
                                                        setState(() => _isSkipPressed = false);
                                                        _navigateToRoute(LoginScreen());
                                                      }
                                                    });
                                                  },
                                                  style: FilledButton.styleFrom(
                                                    elevation: 0,
                                                    minimumSize: Size(buttonWidth * 0.7, 56),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(16),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Skip',
                                                    style: theme.textTheme.labelLarge?.copyWith(
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              /// Material 3 Next Button with Loading State Support
                                              AnimatedScale(
                                                scale: _isNextPressed ? 0.96 : 1.0,
                                                duration: const Duration(milliseconds: 100),
                                                child: FilledButton(
                                                  onPressed: _isNextLoading
                                                      ? null
                                                      : () {
                                                    setState(() {
                                                      _isNextPressed = true;
                                                      _isNextLoading = true;
                                                    });

                                                    Future.delayed(const Duration(milliseconds: 100), () {
                                                      if (mounted) setState(() => _isNextPressed = false);
                                                    });

                                                    // Simulate short network caching or preparation delay
                                                    Future.delayed(const Duration(milliseconds: 800), () {
                                                      if (mounted) {
                                                        _navigateToRoute(const OnboardingTwoScreen());
                                                      }
                                                    });
                                                  },
                                                  style: FilledButton.styleFrom(
                                                    backgroundColor: const Color(0xFF2E7D32),
                                                    foregroundColor: Colors.white,
                                                    elevation: 2,
                                                    minimumSize: Size(buttonWidth, 56),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(16),
                                                    ),
                                                  ),
                                                  child: AnimatedSwitcher(
                                                    duration: const Duration(milliseconds: 200),
                                                    child: _isNextLoading
                                                        ? const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                      ),
                                                    )
                                                        : Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'Next',
                                                          style: theme.textTheme.labelLarge?.copyWith(
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        const Icon(Icons.arrow_forward_rounded, size: 18),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Refined Capsule Indicator Builder Node
  Widget _buildCapsuleIndicator(bool active, ThemeData theme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 32.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: active ? const Color(0xFF2E7D32) : Colors.white.withValues(alpha: 0.4),
      ),
    );
  }
}