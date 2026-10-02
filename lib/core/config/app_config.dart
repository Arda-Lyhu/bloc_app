import 'package:flutter/material.dart';
import '../utils/app_haptics.dart';
import '../utils/app_logger.dart';

/// Environment deployment targets.
enum AppEnvironment { dev, staging, prod }

/// Master configuration & control cockpit for the entire application.
///
/// Configure once in `main.dart` before `runApp()`.
/// All networking, branding, haptics, logging, and feature flags are controlled here.
class AppConfig {
  AppConfig._();

  // ─── App Identity ────────────────────────────────────────────────────────
  static String appName = 'APP SCALE';
  static String appVersion = '1.0.0';
  static IconData appIcon = Icons.shopping_bag_rounded;

  // ─── Environment & Networking ────────────────────────────────────────────
  static AppEnvironment environment = AppEnvironment.dev;
  static String baseUrl = 'https://dummyjson.com';
  static Duration connectTimeout = const Duration(seconds: 15);
  static Duration receiveTimeout = const Duration(seconds: 15);

  // ─── Global Feature & Behavior Toggles ───────────────────────────────────
  static bool enableLogging = true;
  static bool enableHaptics = true;
  static bool enableOnboarding = true;

  // ─── Dynamic Theme & Brand Colors ────────────────────────────────────────
  static Color primaryColor = const Color(0xFFDB3022); // Default brand color
  static Color scaffoldBackground = const Color(0xFFF9F9F9);

  /// Initializes the global application configuration.
  static void init({
    String? appName,
    String? appVersion,
    IconData? appIcon,
    AppEnvironment environment = AppEnvironment.dev,
    String? customBaseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    bool enableLogging = true,
    bool enableHaptics = true,
    bool enableOnboarding = true,
    Color? primaryColor,
    Color? scaffoldBackground,
  }) {
    if (appName != null) AppConfig.appName = appName;
    if (appVersion != null) AppConfig.appVersion = appVersion;
    if (appIcon != null) AppConfig.appIcon = appIcon;
    if (connectTimeout != null) AppConfig.connectTimeout = connectTimeout;
    if (receiveTimeout != null) AppConfig.receiveTimeout = receiveTimeout;
    if (primaryColor != null) AppConfig.primaryColor = primaryColor;
    if (scaffoldBackground != null) AppConfig.scaffoldBackground = scaffoldBackground;

    AppConfig.environment = environment;
    AppConfig.enableLogging = enableLogging;
    AppConfig.enableHaptics = enableHaptics;
    AppConfig.enableOnboarding = enableOnboarding;

    // Apply logging & haptics master toggles
    AppLogger.enabled = enableLogging;
    AppHaptics.enabled = enableHaptics;

    // Resolve Base URL according to environment
    if (customBaseUrl != null && customBaseUrl.isNotEmpty) {
      AppConfig.baseUrl = customBaseUrl;
    } else {
      switch (environment) {
        case AppEnvironment.dev:
          AppConfig.baseUrl = 'https://dummyjson.com';
          break;
        case AppEnvironment.staging:
          AppConfig.baseUrl = 'https://staging-api.dummyjson.com';
          break;
        case AppEnvironment.prod:
          AppConfig.baseUrl = 'https://dummyjson.com';
          break;
      }
    }
  }
}
