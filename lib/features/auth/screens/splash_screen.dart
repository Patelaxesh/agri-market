import 'dart:async';
import 'dart:ui'; // Corrected import

import 'package:agrimarket/features/auth/screens/onboarding_one_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _screenController;
  late final AnimationController _loaderController;

  late final Animation<double> _screenOpacity;
  late final Animation<double> _loaderFadeAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _screenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _screenOpacity = CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeOut,
    );

    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _loaderFadeAnimation = CurvedAnimation(
      parent: _loaderController,
      curve: Curves.easeIn,
    );

    _screenController.forward();

    unawaited(
      Future.delayed(const Duration(milliseconds: 2400), () {
        if (mounted) _loaderController.forward();
      }),
    );

    Timer(const Duration(milliseconds: 3000), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingOneScreen(),
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
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/onboarding1.png'), context);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _screenController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FadeTransition(
          opacity: _screenOpacity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// 1. Background Image with Ken Burns Zoom
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 1.05, end: 1.0),
                duration: const Duration(seconds: 3),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Image.asset(
                  'assets/images/splash_bg.png',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),

              /// 2. Soft Premium Gradient Overlay
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

              /// 3. Responsive Safe Area Interface Node
              SafeArea(
                top: true,
                bottom: false,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: bottomPadding > 0 ? bottomPadding : 32.0,
                        ),
                        child: FadeTransition(
                          opacity: _loaderFadeAnimation,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: -3.0, end: 3.0),
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, value),
                                child: child,
                              );
                            },
                            child: ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 12,
                                  sigmaY: 12,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: .18),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: .12,
                                        ),
                                        blurRadius: 25,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF2E7D32),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
