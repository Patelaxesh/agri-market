import 'dart:async';
import 'dart:ui';

import 'package:agrimarket/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingThreeScreen extends StatefulWidget {
  const OnboardingThreeScreen({super.key});

  @override
  State<OnboardingThreeScreen> createState() => _OnboardingThreeScreenState();
}

class _OnboardingThreeScreenState extends State<OnboardingThreeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _cardController;
  late final Animation<double> _cardFadeAnimation;
  late final Animation<Offset> _cardSlideAnimation;

  bool _isGetStartedLoading = false;
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();

    // 1. Enforce Status Bar styling consistency
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // 2. Setup Staggered Entrance Controller for the Bottom Glass panel
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _cardFadeAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOut,
    );

    _cardSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
        );

    // Deliberate frame offset to allow background Ken Burns initialization first
    unawaited(
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) _cardController.forward();
      }),
    );
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  // Premium Route Cross-Fade + Slight Scale Transition Architecture
  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.98, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
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

    // 3. Absolute system gesture back lockout for seamless introductory UX
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            /// 4. Background Artwork with Premium 7-Second Slow Ken Burns Zoom
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.06, end: 1.0),
              duration: const Duration(seconds: 7),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: Image.asset(
                'assets/images/onboarding_3.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),

            /// 5. Contrast Protecting Vignette Mask Layer
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: .03),
                      Colors.black.withValues(alpha: .07),
                    ],
                  ),
                ),
              ),
            ),

            /// 6. Responsive Viewport Constraints Wrapper
            SafeArea(
              top: true,
              bottom: true,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  final isTablet =
                      constraints.maxWidth >= 600 &&
                      constraints.maxWidth < 1024;

                  // Responsively calculate the Material 3 Button bounds explicitly
                  final containerWidth = isMobile
                      ? double.infinity
                      : (isTablet ? 380.0 : 440.0);

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 460),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /// Frosted Glass Panel Container
                            SlideTransition(
                              position: _cardSlideAnimation,
                              child: FadeTransition(
                                opacity: _cardFadeAnimation,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 12,
                                      sigmaY: 12,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: .18,
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: .3,
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: .08,
                                            ),
                                            blurRadius: 25,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          /// Premium Capsule Indicators (Page 3 Active)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              _buildCapsuleIndicator(false),
                                              // Index 0
                                              _buildCapsuleIndicator(false),
                                              // Index 1
                                              _buildCapsuleIndicator(true),
                                              // Index 2 (Active Finale)
                                            ],
                                          ),

                                          const SizedBox(height: 32),

                                          /// 7. Micro-Interacted Material 3 Get Started Button Node
                                          AnimatedScale(
                                            scale: _isButtonPressed
                                                ? 0.97
                                                : 1.0,
                                            duration: const Duration(
                                              milliseconds: 100,
                                            ),
                                            child: SizedBox(
                                              width: containerWidth,
                                              height: 56,
                                              child: FilledButton(
                                                onPressed: _isGetStartedLoading
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          _isButtonPressed =
                                                              true;
                                                          _isGetStartedLoading =
                                                              true;
                                                        });

                                                        Future.delayed(
                                                          const Duration(
                                                            milliseconds: 100,
                                                          ),
                                                          () {
                                                            if (mounted) {
                                                              setState(
                                                                () =>
                                                                    _isButtonPressed =
                                                                        false,
                                                              );
                                                            }
                                                          },
                                                        );

                                                        // Professional async pacing engine delay prior to login entry
                                                        Future.delayed(
                                                          const Duration(
                                                            milliseconds: 800,
                                                          ),
                                                          () {
                                                            if (mounted) {
                                                              _navigateToLogin();
                                                            }
                                                          },
                                                        );
                                                      },
                                                style: FilledButton.styleFrom(
                                                  backgroundColor: const Color(
                                                    0xFF2E7D32,
                                                  ),
                                                  foregroundColor: Colors.white,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                  ),
                                                ),
                                                child: AnimatedSwitcher(
                                                  duration: const Duration(
                                                    milliseconds: 200,
                                                  ),
                                                  child: _isGetStartedLoading
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
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Get Started',
                                                              style: theme
                                                                  .textTheme
                                                                  .labelLarge
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.3,
                                                                  ),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            // Premium Micro-Sliding Animated Icon
                                                            AnimatedContainer(
                                                              duration:
                                                                  const Duration(
                                                                    milliseconds:
                                                                        150,
                                                                  ),
                                                              padding:
                                                                  EdgeInsets.only(
                                                                    left:
                                                                        _isButtonPressed
                                                                        ? 4.0
                                                                        : 0.0,
                                                                  ),
                                                              child: const Icon(
                                                                Icons
                                                                    .arrow_forward_rounded,
                                                                size: 18,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ),
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

  /// Interactive Capsule Navigation Engine Indicator Builder
  Widget _buildCapsuleIndicator(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 32.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: active
            ? const Color(0xFF2E7D32)
            : Colors.white.withValues(alpha: 0.4),
        boxShadow: active
            ? [
                BoxShadow(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.4),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
    );
  }
}
