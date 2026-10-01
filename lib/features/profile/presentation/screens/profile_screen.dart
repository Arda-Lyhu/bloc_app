import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_scale/app/router/route_name.dart';
import '../../../../app/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.pushNamed(RouteName.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Header Info
            GestureDetector(
              onTap: () => context.pushNamed(RouteName.login),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Matilda Brown',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'lyhu1401@mail.com',
                        style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Profile Menu Options
            _buildProfileTile(
              title: 'My orders',
              subtitle: 'Already have 12 orders',
              onTap: () => context.pushNamed(RouteName.orders),
            ),
            _buildProfileTile(
              title: 'Shipping addresses',
              subtitle: '3 addresses',
              onTap: () => context.pushNamed(RouteName.checkout),
            ),
            _buildProfileTile(
              title: 'Notifications',
              subtitle: 'Sales & app alerts',
              onTap: () => context.pushNamed(RouteName.notifications),
            ),
            _buildProfileTile(
              title: 'Settings',
              subtitle: 'Notifications, password',
              onTap: () => context.pushNamed(RouteName.settings),
            ),
            _buildProfileTile(
              title: 'Logout',
              subtitle: 'Sign out of account',
              onTap: () => context.goNamed(RouteName.login),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            subtitle,
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          trailing:
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
