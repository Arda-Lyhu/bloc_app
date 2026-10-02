import 'package:flutter/material.dart';

/// A reusable, premium 3D-styled isometric artwork component featuring:
/// - Multi-layered gradient sphere with specular highlights
/// - Layered frosted-glass backing plate with rim lighting
/// - Ambient backlight glow and isometric contact ground shadow
/// - Configurable orbiting 3D floating orb badges
///
/// Perfect for Onboarding screens, Empty states, Success milestones, or Feature highlights.
class ThreeDIconArtwork extends StatelessWidget {
  const ThreeDIconArtwork({
    super.key,
    required this.mainIcon,
    required this.gradientColors,
    this.badgeIcon1,
    this.badgeIcon2,
    this.shadowColor,
    this.size = 240,
    this.mainIconSize = 58,
  });

  /// Primary center icon.
  final IconData mainIcon;

  /// 2 or 3 stop linear gradient for the center orb & ambient glow.
  final List<Color> gradientColors;

  /// Optional top-right floating badge icon.
  final IconData? badgeIcon1;

  /// Optional bottom-left floating badge icon.
  final IconData? badgeIcon2;

  /// Contact shadow color (defaults to first gradient color).
  final Color? shadowColor;

  /// Overall canvas box size (width & height).
  final double size;

  /// Size of the primary center icon.
  final double mainIconSize;

  @override
  Widget build(BuildContext context) {
    final primaryColor = gradientColors.first;
    final secondaryColor = gradientColors.last;
    final effectiveShadow = shadowColor ?? primaryColor;

    return SizedBox(
      width: size + 20,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Ambient Glow Backlight
          Positioned(
            bottom: 20,
            child: Container(
              width: size * 0.75,
              height: size * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primaryColor.withValues(alpha: 0.35),
                    primaryColor.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. 3D Isometric Base Contact Shadow
          Positioned(
            bottom: 12,
            child: Container(
              width: size * 0.85,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(size * 0.85, 48)),
                gradient: RadialGradient(
                  colors: [
                    effectiveShadow.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 3. 3D Frosted Glass Backing Shield
          Center(
            child: Container(
              width: size * 0.7,
              height: size * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size * 0.18),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withValues(alpha: 0.22),
                    secondaryColor.withValues(alpha: 0.08),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: effectiveShadow.withValues(alpha: 0.25),
                    blurRadius: 28,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
            ),
          ),

          // 4. Center 3D Main Sphere / Icon Plate
          Center(
            child: Container(
              width: size * 0.52,
              height: size * 0.52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: effectiveShadow.withValues(alpha: 0.5),
                    blurRadius: 22,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(-4, -4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Specular highlight line on top curve
                  Positioned(
                    top: 10,
                    left: 20,
                    child: Container(
                      width: size * 0.22,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.45),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Center Icon
                  Icon(
                    mainIcon,
                    size: mainIconSize,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          // 5. Floating Orbital Badge 1 (Top Right)
          if (badgeIcon1 != null)
            Positioned(
              top: 24,
              right: 18,
              child: _FloatingOrbitBadge(
                icon: badgeIcon1!,
                gradient: [
                  Colors.amber.shade400,
                  Colors.orange.shade600,
                ],
                shadowColor: Colors.orange.shade900,
                size: 46,
                iconSize: 22,
              ),
            ),

          // 6. Floating Orbital Badge 2 (Bottom Left)
          if (badgeIcon2 != null)
            Positioned(
              bottom: 30,
              left: 20,
              child: _FloatingOrbitBadge(
                icon: badgeIcon2!,
                gradient: [
                  Colors.cyan.shade300,
                  Colors.blue.shade600,
                ],
                shadowColor: Colors.blue.shade900,
                size: 42,
                iconSize: 20,
              ),
            ),
        ],
      ),
    );
  }
}

/// Floating mini orb badge with glossy border and elevation.
class _FloatingOrbitBadge extends StatelessWidget {
  const _FloatingOrbitBadge({
    required this.icon,
    required this.gradient,
    required this.shadowColor,
    required this.size,
    required this.iconSize,
  });

  final IconData icon;
  final List<Color> gradient;
  final Color shadowColor;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.7),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.5),
            blurRadius: 4,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
