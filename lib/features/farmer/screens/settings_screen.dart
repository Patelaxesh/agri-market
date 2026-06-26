import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const Color primaryColor = Color(0xFF2E7D32);

  bool orderNotifications = true;
  bool promotionNotifications = false;
  bool emailNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F3),

      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    value: orderNotifications,
                    activeColor: primaryColor,
                    title: const Text('Order Notifications'),
                    subtitle: const Text(
                      'Get notified about new orders',
                    ),
                    onChanged: (value) {
                      setState(() {
                        orderNotifications = value;
                      });
                    },
                  ),

                  const Divider(height: 1),

                  SwitchListTile(
                    value: promotionNotifications,
                    activeColor: primaryColor,
                    title: const Text('Promotional Notifications'),
                    subtitle: const Text(
                      'Receive offers and updates',
                    ),
                    onChanged: (value) {
                      setState(() {
                        promotionNotifications = value;
                      });
                    },
                  ),

                  const Divider(height: 1),

                  SwitchListTile(
                    value: emailNotifications,
                    activeColor: primaryColor,
                    title: const Text('Email Notifications'),
                    subtitle: const Text(
                      'Receive updates by email',
                    ),
                    onChanged: (value) {
                      setState(() {
                        emailNotifications = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'General',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Language'),
                    subtitle: Text('English'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('App Version'),
                    subtitle: Text('1.0.0'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Legal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text('Privacy Policy'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),

                  Divider(height: 1),

                  ListTile(
                    leading: Icon(Icons.description_outlined),
                    title: Text('Terms & Conditions'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}