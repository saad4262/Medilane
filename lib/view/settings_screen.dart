import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.teal, // You can customize the color
      ),
      body: ListView(
        children: [
          // Account
          ListTile(
            leading: const Icon(Icons.person, color: Colors.teal),
            title: const Text('Account'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to Account Settings screen
            },
          ),

          const Divider(),

          // Notifications
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.teal),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to Notifications Settings screen
            },
          ),

          const Divider(),

          // Privacy & Security
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.teal),
            title: const Text('Privacy & Security'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to Privacy Settings screen
            },
          ),

          const Divider(),

          // Theme & Display (Dark Mode toggle)
          ListTile(
            leading: const Icon(Icons.color_lens, color: Colors.teal),
            title: const Text('Theme & Display'),
            trailing: Switch(
              value: false, // Replace with your dark mode state variable
              onChanged: (val) {
                // Toggle dark mode here
              },
              activeColor: Colors.teal,
            ),
            onTap: () {},
          ),

          const Divider(),

          // About
          ListTile(
            leading: const Icon(Icons.info, color: Colors.teal),
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to About screen
            },
          ),

          const Divider(),

          // Log Out Button (optional)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle logout
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
