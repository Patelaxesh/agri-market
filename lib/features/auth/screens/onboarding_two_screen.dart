import 'dart:async';
import 'dart:ui';

import 'package:agrimarket/features/auth/screens/login_screen.dart';
import 'package:agrimarket/features/auth/screens/onboarding_three_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingTwoScreen extends StatefulWidget {
  const OnboardingTwoScreen({super.key});

  @override
  State<OnboardingTwoScreen> createState() => _OnboardingTwoScreenState();
}

class _OnboardingTwoScreenState extends State<OnboardingTwoScreen>
    with TickerProviderStateMixin {
  late final AnimationController _cardController;
  late final Animation<double> _cardFadeAnimation;
  late final Animation<Offset> _cardSlideAnimation;

  bool _isNextLoading = false;
  bool _isSkipPressed = false;
  bool _isNextPressed = false;

  @override
  void initState() {
    super.initState();

    // 1. Transparent Status Bar Style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // 2. Panel Entrance Micro-interactions
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _cardFadeAnimation = CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeOut,
    );

    _cardSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
        );

    // Stagger presentation slightly behind background layer
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

  // Premium Route cross-fade scale transitions
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
    final _ = MediaQuery.of(context).padding.bottom;

    // 3. Prevent accidental backing out during onboarding setup
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            /// 4. Background Image with Premium Ken Burns Animation (1.06 -> 1.0)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.06, end: 1.0),
              duration: const Duration(seconds: 4),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: Image.asset(
                'assets/images/onboarding_2.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),

            /// 5. Subtle Gradient Protection Layer
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: .04),
                      Colors.black.withValues(alpha: .06),
                    ],
                  ),
                ),
              ),
            ),

            /// 6. Responsive Content Core
            SafeArea(
              top: true,
              bottom: true,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Adaptive sizing calculations based on device width
                  final isMobile = constraints.maxWidth < 600;
                  final isTablet =
                      constraints.maxWidth >= 600 &&
                      constraints.maxWidth < 1024;
                  final buttonWidth = isMobile
                      ? 150.0
                      : (isTablet ? 175.0 : 210.0);

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
                            /// Frosted Glass Control Panel
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
                                          /// Premium Capsule Indicators (Page 2 Active)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              _buildCapsuleIndicator(false),
                                              // Index 0
                                              _buildCapsuleIndicator(true),
                                              // Index 1 (Active)
                                              _buildCapsuleIndicator(false),
                                              // Index 2
                                            ],
                                          ),

                                          const SizedBox(height: 32),

                                          /// Bottom Controls Row Action Pipeline
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              /// Material 3 Filled Tonal Skip Button + Scale Effect
                                              AnimatedScale(
                                                scale: _isSkipPressed
                                                    ? 0.96
                                                    : 1.0,
                                                duration: const Duration(
                                                  milliseconds: 100,
                                                ),
                                                child: FilledButton.tonal(
                                                  onPressed: _isNextLoading
                                                      ? null
                                                      : () {
                                                          setState(
                                                            () =>
                                                                _isSkipPressed =
                                                                    true,
                                                          );
                                                          Future.delayed(
                                                            const Duration(
                                                              milliseconds: 100,
                                                            ),
                                                            () {
                                                              if (mounted) {
                                                                setState(
                                                                  () =>
                                                                      _isSkipPressed =
                                                                          false,
                                                                );
                                                                _navigateToRoute(
                                                                  LoginScreen(),
                                                                );
                                                              }
                                                            },
                                                          );
                                                        },
                                                  style: FilledButton.styleFrom(
                                                    elevation: 0,
                                                    minimumSize: Size(
                                                      buttonWidth * 0.72,
                                                      54,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            14,
                                                          ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Skip',
                                                    style: theme
                                                        .textTheme
                                                        .labelLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ),
                                              ),

                                              /// Material 3 Next Button with Embedded Async Loader State
                                              AnimatedScale(
                                                scale: _isNextPressed
                                                    ? 0.96
                                                    : 1.0,
                                                duration: const Duration(
                                                  milliseconds: 100,
                                                ),
                                                child: FilledButton(
                                                  onPressed: _isNextLoading
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            _isNextPressed =
                                                                true;
                                                            _isNextLoading =
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
                                                                      _isNextPressed =
                                                                          false,
                                                                );
                                                              }
                                                            },
                                                          );

                                                          // Smooth UX loading delay prior to push
                                                          Future.delayed(
                                                            const Duration(
                                                              milliseconds: 700,
                                                            ),
                                                            () {
                                                              if (mounted) {
                                                                _navigateToRoute(
                                                                  const OnboardingThreeScreen(),
                                                                );
                                                              }
                                                            },
                                                          );
                                                        },
                                                  style: FilledButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF2E7D32),
                                                    foregroundColor:
                                                        Colors.white,
                                                    elevation: 2,
                                                    minimumSize: Size(
                                                      buttonWidth,
                                                      54,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            14,
                                                          ),
                                                    ),
                                                  ),
                                                  child: AnimatedSwitcher(
                                                    duration: const Duration(
                                                      milliseconds: 200,
                                                    ),
                                                    child: _isNextLoading
                                                        ? const SizedBox(
                                                            width: 18,
                                                            height: 18,
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                    Color
                                                                  >(
                                                                    Colors
                                                                        .white,
                                                                  ),
                                                            ),
                                                          )
                                                        : Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'Next',
                                                                style: theme
                                                                    .textTheme
                                                                    .labelLarge
                                                                    ?.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .arrow_forward_rounded,
                                                                size: 18,
                                                              ),
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

  /// Refined Premium Capsule Page Dot
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
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
    );
  }
}
