import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _salesNotifications = true;
  bool _newArrivalsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Personal Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                  labelText: 'Full Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            const Text('Notifications',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Sales Notifications'),
              activeThumbColor: AppColors.primary,
              value: _salesNotifications,
              onChanged: (val) => setState(() => _salesNotifications = val),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('New Arrivals Notifications'),
              activeThumbColor: AppColors.primary,
              value: _newArrivalsNotifications,
              onChanged: (val) =>
                  setState(() => _newArrivalsNotifications = val),
            ),
          ],
        ),
      ),
    );
  }
}
