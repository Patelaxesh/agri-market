import 'dart:ui';

import 'package:agrimarket/features/admin/screens/admin_bottom_nav_screen.dart';
import 'package:agrimarket/features/auth/models/user_model.dart';
import 'package:agrimarket/features/auth/providers/auth_provider.dart';
import 'package:agrimarket/features/auth/screens/forgot_password_screen.dart';
import 'package:agrimarket/features/auth/screens/signup_screen.dart';
import 'package:agrimarket/features/buyer/screens/buyer_bottom_nav_screen.dart';
import 'package:agrimarket/features/farmer/screens/farmer_bottom_nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color accentColor = Color(0xFFE8F5E9);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool obscurePassword = true;
  bool rememberMe = false;
  bool loading = false;

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
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    /// Admin Local Bypass Testing
    if (email == '2' && password == '2') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminBottomNavScreen()),
      );
      return;
    }
    /// Vendor Local Bypass Testing
    else if (email == '1' && password == '1') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BuyerBottomNavScreen()),
      );
      return;
    }
    /// Farmer Local Bypass Testing
    else if (email == '0' && password == '0') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FarmerBottomNavScreen()),
      );
      return;
    }

    /// Dynamic Live Production Authentication Flow
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    UserModel? authenticatedUser = await authProvider.login(email, password);

    if (authenticatedUser != null && mounted) {
      if (authenticatedUser.role == 'farmer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const FarmerBottomNavScreen()),
        );
      } else if (authenticatedUser.role == 'buyer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BuyerBottomNavScreen()),
        );
      } else if (authenticatedUser.role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminBottomNavScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unknown system level designation.')),
        );
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.errorMessage ?? 'Invalid email or password',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> continueWithGoogle() async {
    String webClientId =
        "143820315515-7e08janu33g60fod9vcs3240a8sg6406.apps.googleusercontent.com";

    try {
      FocusScope.of(context).unfocus();
      setState(() {
        loading = true;
      });

      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(serverClientId: webClientId);
      GoogleSignInAccount? account = await signIn.authenticate();

      GoogleSignInAuthentication googleAuth = account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      if (userCredential.user != null && mounted) {
        final loggedInUser = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? 'Buyer Account',
          mobile: userCredential.user!.phoneNumber ?? '',
          role: 'buyer',
          createdAt: DateTime.now(),
        );

        Provider.of<AuthProvider>(
          context,
          listen: false,
        ).setAuthenticatedUser(loggedInUser);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BuyerBottomNavScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isUiBusy = authProvider.isLoading || loading;
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      body: Stack(
        children: [
          /// Background Layers
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFEBF2EC), Color(0xFFF4F8F5), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// Background circles
          Positioned(
            top: -50,
            right: -50,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: accentColor.withValues(alpha: 0.4),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -60,
            child: CircleAvatar(
              radius: 140,
              backgroundColor: accentColor.withValues(alpha: 0.3),
            ),
          ),

          /// Master Interactive Interface Form View
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: isTablet ? 32 : 16,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeader(isTablet),
                            SizedBox(height: isTablet ? 40 : 30),
                            Card(
                              elevation: 4,
                              shadowColor: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              color: Colors.white.withValues(alpha: 0.9),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    _buildEmailField(isUiBusy),
                                    const SizedBox(height: 20),
                                    _buildPasswordField(isUiBusy),
                                    const SizedBox(height: 16),
                                    _buildRememberMeForgotRow(isUiBusy),
                                    const SizedBox(height: 24),
                                    _buildLoginButton(isUiBusy),
                                    const SizedBox(height: 24),
                                    _buildDivider(),
                                    const SizedBox(height: 24),
                                    _buildGoogleButton(isUiBusy),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
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

          /// Global Application Loading Overlay View
          if (isUiBusy)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.25),
                  child: Center(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            primaryColor,
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
    );
  }

  /// -------------------------------------------------------------
  /// Sub-Interface Functional Modular Construction Layout Components
  /// -------------------------------------------------------------

  Widget _buildHeader(bool isTablet) {
    return Semantics(
      label: 'AgriMarket Branding Header',
      container: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fresh Produce • Fair Prices • Direct Trade',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: primaryColor.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Hero(
            tag: 'agrimarket_logo_hero',
            child: Image.asset(
              'assets/images/agrimarket_logo.png',
              height: isTablet ? 76 : 64,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.eco, size: 54, color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField(bool isUiBusy) {
    return AutofillGroup(
      child: TextFormField(
        controller: emailController,
        focusNode: _emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autofillHints: const [AutofillHints.email],
        enabled: !isUiBusy,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          labelText: 'Email Address',
          prefixIcon: const Icon(Icons.email_outlined),
          filled: true,
          fillColor: const Color(0xFFF4F7F4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: primaryColor, width: 1.5),
          ),
        ),
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your email address';
          }
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value.trim()) &&
              value != '0' &&
              value != '1' &&
              value != '2') {
            return 'Please enter a valid email format';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(bool isUiBusy) {
    return TextFormField(
      controller: passwordController,
      focusNode: _passwordFocusNode,
      obscureText: obscurePassword,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      enabled: !isUiBusy,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
          icon: Icon(
            obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFF4F7F4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
      onFieldSubmitted: (_) => _login(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Widget _buildRememberMeForgotRow(bool isUiBusy) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: rememberMe,
                activeColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: isUiBusy
                    ? null
                    : (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
              ),
            ),
            const SizedBox(width: 8),
            const Text('Remember Me', style: TextStyle(fontSize: 14)),
          ],
        ),
        GestureDetector(
          onTap: isUiBusy
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ForgotPasswordScreen(),
                    ),
                  );
                },
          child: const MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Forgot Password ',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Icon(Icons.arrow_forward, size: 14, color: primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(bool isUiBusy) {
    return SizedBox(
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isUiBusy
              ? null
              : const LinearGradient(
                  colors: [primaryColor, Color(0xFF388E3C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: FilledButton(
          onPressed: isUiBusy ? null : _login,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.grey.shade300,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: isUiBusy
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Continue with',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildGoogleButton(bool isUiBusy) {
    return SizedBox(
      height: 56,
      child: FilledButton.tonal(
        onPressed: isUiBusy ? null : continueWithGoogle,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFF4F7F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Semantics(
          label:
              "Authenticate securely via external Google credential path Services",
          button: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google_logo.png',
                height: 22,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.g_mobiledata, size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Continue with Google',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
          "New to AgriMarket?",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        TextButton(
          onPressed: isUiBusy
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
          child: const Row(
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 2),
              Icon(Icons.arrow_forward, size: 14, color: primaryColor),
            ],
          ),
        ),
      ],
    );
  }
}
