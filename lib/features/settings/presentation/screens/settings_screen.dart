import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Matilda Brown');
  bool _salesNotifications = true;
  bool _newArrivalsNotifications = false;
  bool _hapticsEnabled = AppConfig.enableHaptics;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.h2('Settings'),
      ),
      body: ResponsiveContainer(
        maxWidth: 700,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText.title(
                'Personal Information',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _nameController,
                label: 'Full Name',
                prefixIcon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: 32),
              const AppText.title(
                'Preferences & Feedback',
                fontWeight: FontWeight.bold,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.language_rounded, size: 20),
                ),
                title: AppText.subtitle(context.tr('language'), fontWeight: FontWeight.bold),
                subtitle: AppText.caption(
                  '${context.language.flagEmoji} ${context.language.nativeName} (${context.language.name})',
                  isMuted: true,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () async {
                  await LanguageSelectorSheet.show(context);
                  setState(() {});
                },
              ),
              const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: AppText.subtitle(context.tr('hapticsFeedback')),
                subtitle: const AppText.caption(
                  'Tactile feedback on button presses & errors',
                  isMuted: true,
                ),
                value: _hapticsEnabled,
                onChanged: (val) {
                  setState(() => _hapticsEnabled = val);
                  AppConfig.enableHaptics = val;
                  AppHaptics.enabled = val;
                  if (val) AppHaptics.buttonPress();
                },
              ),
              const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const AppText.subtitle('Sales Notifications'),
                subtitle: const AppText.caption(
                  'Special discounts and seasonal offers',
                  isMuted: true,
                ),
                value: _salesNotifications,
                onChanged: (val) {
                  AppHaptics.selection();
                  setState(() => _salesNotifications = val);
                },
              ),
              const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const AppText.subtitle('New Arrivals'),
                subtitle: const AppText.caption(
                  'Get notified when new collections drop',
                  isMuted: true,
                ),
                value: _newArrivalsNotifications,
                onChanged: (val) {
                  AppHaptics.selection();
                  setState(() => _newArrivalsNotifications = val);
                },
              ),
              const SizedBox(height: 40),
              AppButton(
                label: 'Save Changes',
                icon: const Icon(Icons.check_rounded, size: 20),
                onPressed: () {
                  AppAlerts.showSuccess(
                      context, 'Settings saved successfully!');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
