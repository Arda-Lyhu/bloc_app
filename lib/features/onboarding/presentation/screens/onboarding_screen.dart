import '../../../../app/router/route_name.dart';
import '../../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Data model for an onboarding slide.
class OnboardingItem {
  final String subtitle;
  final String title;
  final String description;
  final IconData mainIcon;
  final IconData? badgeIcon1;
  final IconData? badgeIcon2;
  final List<Color> gradientColors;

  const OnboardingItem({
    required this.subtitle,
    required this.title,
    required this.description,
    required this.mainIcon,
    this.badgeIcon1,
    this.badgeIcon2,
    required this.gradientColors,
  });
}

/// A dynamic, 100% reusable Onboarding Screen with:
/// - Custom brand title & logo
/// - Custom slide items (or built-in defaults)
/// - Custom navigation callbacks for Finish, Skip, and Guest mode
/// - Built-in 3D isometric artwork & tactile haptic vibration
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    this.appName = 'APP SCALE',
    this.appIcon = Icons.shopping_bag_rounded,
    this.items,
    this.onFinish,
    this.onSkip,
    this.onExploreAsGuest,
  });

  /// Brand name displayed in the top header.
  final String appName;

  /// Brand icon displayed in the top header.
  final IconData appIcon;

  /// Custom list of onboarding slides. If null, default e-commerce slides are used.
  final List<OnboardingItem>? items;

  /// Callback when user completes onboarding. Defaults to navigating to Login.
  final VoidCallback? onFinish;

  /// Callback when user skips onboarding. Defaults to navigating to Login.
  final VoidCallback? onSkip;

  /// Callback when user taps "Browse as Guest". Defaults to navigating to Main Shell.
  final VoidCallback? onExploreAsGuest;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<OnboardingItem> _defaultItems = [
    OnboardingItem(
      subtitle: 'EXCLUSIVE DISCOVERY',
      title: 'Explore Top Trends & Hot Deals',
      description:
          'Discover thousands of handpicked fashion, beauty, and tech products with personalized daily discounts.',
      mainIcon: Icons.storefront_rounded,
      badgeIcon1: Icons.auto_awesome_rounded,
      badgeIcon2: Icons.local_offer_rounded,
      gradientColors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFA855F7)],
    ),
    OnboardingItem(
      subtitle: 'SMART & SECURE',
      title: 'Instant & Safe 1-Click Checkout',
      description:
          'Enjoy ultra-secure encrypted payments with Apple Pay, cards, or digital wallets alongside instant receipt tracking.',
      mainIcon: Icons.shield_rounded,
      badgeIcon1: Icons.verified_user_rounded,
      badgeIcon2: Icons.credit_card_rounded,
      gradientColors: [Color(0xFFEC4899), Color(0xFFF43F5E), Color(0xFFFB7185)],
    ),
    OnboardingItem(
      subtitle: 'SUPER FAST LOGISTICS',
      title: 'Express Doorstep Delivery',
      description:
          'Track your package in real-time from our warehouse to your doorstep with guaranteed on-time express dispatch.',
      mainIcon: Icons.local_shipping_rounded,
      badgeIcon1: Icons.bolt_rounded,
      badgeIcon2: Icons.inventory_2_rounded,
      gradientColors: [Color(0xFF0D9488), Color(0xFF10B981), Color(0xFF34D399)],
    ),
  ];

  List<OnboardingItem> get _effectiveItems => widget.items ?? _defaultItems;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    AppHaptics.selection();
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _effectiveItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _handleFinish();
    }
  }

  void _handleFinish() {
    AppHaptics.success();
    if (widget.onFinish != null) {
      widget.onFinish!();
    } else {
      context.goNamed(RouteName.login);
    }
  }

  void _handleSkip() {
    AppHaptics.buttonPress();
    if (widget.onSkip != null) {
      widget.onSkip!();
    } else {
      _handleFinish();
    }
  }

  void _handleGuest() {
    AppHaptics.buttonPress();
    if (widget.onExploreAsGuest != null) {
      widget.onExploreAsGuest!();
    } else {
      context.goNamed(RouteName.mainShell);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = _effectiveItems;
    final isLastPage = _currentPage == items.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.tertiary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          widget.appIcon,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.appName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _handleSkip,
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurfaceVariant,
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),

            // Middle: Swipeable PageView with 3D Illustration Cards
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: items.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        // Reusable 3D Visual Art Component
                        ThreeDIconArtwork(
                          mainIcon: item.mainIcon,
                          badgeIcon1: item.badgeIcon1,
                          badgeIcon2: item.badgeIcon2,
                          gradientColors: item.gradientColors,
                        ),
                        const SizedBox(height: 40),

                        // Subtitle Pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: item.gradientColors.first.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: item.gradientColors.first.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            item.subtitle,
                            style: TextStyle(
                              color: item.gradientColors.first,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Title
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.55,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Navigation & Controls
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Dynamic Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(items.length, (index) {
                      final isSelected = _currentPage == index;
                      final activeColor = items[_currentPage].gradientColors.first;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isSelected ? 32 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? activeColor
                              : theme.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: activeColor.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : null,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 28),

                  // Main Button
                  AppButton(
                    label: isLastPage ? 'GET STARTED' : 'CONTINUE',
                    icon: Icon(
                      isLastPage
                          ? Icons.rocket_launch_rounded
                          : Icons.arrow_forward_rounded,
                      size: 20,
                    ),
                    backgroundColor: items[_currentPage].gradientColors.first,
                    onPressed: _nextPage,
                  ),
                  const SizedBox(height: 10),

                  // Guest Entry
                  TextButton(
                    onPressed: _handleGuest,
                    child: Text(
                      'Browse products as Guest',
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
