import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_name.dart';
import '../../../../core/core.dart';
import '../../../auth/presentation/bloc/user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (_, state) =>
          state is UserLogoutSuccess ||
          state is UserLogoutError ||
          state is UserLogoutLoading,
      listener: (context, state) {
        if (state is UserLogoutSuccess) {
          context.goNamed(RouteName.login);
        }
        if (state is UserLogoutError) {
          AppAlerts.showError(context, state.message);
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        buildWhen: (_, state) =>
            state is UserLogoutLoading ||
            state is UserLogoutSuccess ||
            state is UserLogoutError ||
            state is UserInitial,
        builder: (context, state) {
          final isLoggingOut = state is UserLogoutLoading;

          return Scaffold(
            appBar: AppBar(
              title: const AppText.h2('My Profile'),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    AppHaptics.selection();
                    context.pushNamed(RouteName.search);
                  },
                ),
              ],
            ),
            body: AppLoadingOverlay(
              isLoading: isLoggingOut,
              message: 'Signing out...',
              child: ResponsiveContainer(
                maxWidth: 700,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // User Header Info
                      GestureDetector(
                        onTap: () {
                          AppHaptics.selection();
                          context.pushNamed(RouteName.login);
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 40,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  AppText.title('Matilda Brown',
                                      fontWeight: FontWeight.bold),
                                  SizedBox(height: 4),
                                  AppText.caption('lyhu1401@mail.com',
                                      isMuted: true),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                size: 16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Profile Menu Options
                      _buildProfileTile(
                        context: context,
                        title: 'My orders',
                        subtitle: 'Already have 12 orders',
                        icon: Icons.shopping_bag_outlined,
                        onTap: () => context.pushNamed(RouteName.orders),
                      ),
                      _buildProfileTile(
                        context: context,
                        title: 'Shipping addresses',
                        subtitle: '3 addresses',
                        icon: Icons.location_on_outlined,
                        onTap: () => context.pushNamed(RouteName.checkout),
                      ),
                      _buildProfileTile(
                        context: context,
                        title: 'Notifications',
                        subtitle: 'Sales & app alerts',
                        icon: Icons.notifications_outlined,
                        onTap: () => context.pushNamed(RouteName.notifications),
                      ),
                      _buildProfileTile(
                        context: context,
                        title: context.tr('settings'),
                        subtitle: 'Notifications, password',
                        icon: Icons.settings_outlined,
                        onTap: () => context.pushNamed(RouteName.settings),
                      ),
                      _buildProfileTile(
                        context: context,
                        title: context.tr('language'),
                        subtitle: '${context.language.flagEmoji} ${context.language.nativeName}',
                        icon: Icons.language_rounded,
                        onTap: () => LanguageSelectorSheet.show(context),
                      ),

                      // Logout with confirmation modal & haptics
                      _buildProfileTile(
                        context: context,
                        title: 'Logout',
                        subtitle: 'Sign out of account',
                        icon: Icons.logout_rounded,
                        isDestructive: true,
                        isLoading: isLoggingOut,
                        onTap: isLoggingOut
                            ? null
                            : () async {
                                final confirmed = await AppDialogs.showConfirm(
                                  context: context,
                                  title: 'Sign Out',
                                  message:
                                      'Are you sure you want to sign out from your account?',
                                  confirmText: 'Log Out',
                                  isDestructive: true,
                                  icon: Icons.logout_rounded,
                                );
                                if (confirmed == true && context.mounted) {
                                  context
                                      .read<UserBloc>()
                                      .add(LogoutSubmited());
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    IconData? icon,
    bool isDestructive = false,
    bool isLoading = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: icon != null
              ? Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (isDestructive
                            ? colorScheme.error
                            : colorScheme.primary)
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color:
                        isDestructive ? colorScheme.error : colorScheme.primary,
                  ),
                )
              : null,
          title: AppText.subtitle(
            title,
            fontWeight: FontWeight.w600,
            isError: isDestructive,
          ),
          subtitle: AppText.caption(
            subtitle,
            isMuted: true,
          ),
          trailing: isLoading
              ? const AppLoader.small()
              : Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
          onTap: () {
            AppHaptics.selection();
            onTap?.call();
          },
        ),
        Divider(
          height: 1,
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ],
    );
  }
}
