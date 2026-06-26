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

class _LoginScreenState extends State<LoginScreen> {
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color backgroundColor = Color(0xFFF8FAF8);
  static const Color fieldColor = Color(0xFFF3F6F3);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

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

  bool loading = false;

  Future<void> continueWithGoogle() async {
    String webClientId =
        "143820315515-7e08janu33g60fod9vcs3240a8sg6406.apps.googleusercontent.com";

    try {
      setState(() {
        loading = true;
      });

      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(serverClientId: webClientId);
      GoogleSignInAccount? account = await signIn.authenticate();



      GoogleSignInAuthentication googleAuth =  account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      if (userCredential.user != null && mounted) {
        // Construct the local session object mapping data context defaults to 'buyer'
        final loggedInUser = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
          name: userCredential.user!.displayName ?? 'Buyer Account',
          mobile: userCredential.user!.phoneNumber ?? '',
          role: 'buyer',
          createdAt:
              DateTime.now(), // Default assignment logic forced directly here
        );

        // Synchronize state provider globally inside tree structure
        Provider.of<AuthProvider>(
          context,
          listen: false,
        ).setAuthenticatedUser(loggedInUser);

        // Seamless route navigation target directly initialized
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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// Logo
                Center(
                  child: Image.asset(
                    'assets/images/agrimarket_logo.png',
                    height: 110,
                  ),
                ),

                const SizedBox(height: 24),

                /// Welcome Text
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Sign in to continue trading on AgriMarket',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),

                const SizedBox(height: 35),

                /// Email Field
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !isUiBusy,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: fieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                /// Password Field
                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  enabled: !isUiBusy,
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
                    fillColor: fieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                /// Remember Me + Forgot Password
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      activeColor: primaryColor,
                      onChanged: isUiBusy
                          ? null
                          : (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                    ),
                    const Text('Remember Me', style: TextStyle(fontSize: 14)),
                    const Spacer(),
                    TextButton(
                      onPressed: isUiBusy
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Login Button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: authProvider.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : ElevatedButton(
                          onPressed: isUiBusy ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),

                const SizedBox(height: 30),

                /// Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.grey.shade300, thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey.shade300, thickness: 1),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// Google Sign In
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: OutlinedButton(
                    onPressed: isUiBusy ? null : continueWithGoogle,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google_logo.png',
                                height: 24,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 35),

                /// Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: isUiBusy
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpScreen(),
                                ),
                              );
                            },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
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
