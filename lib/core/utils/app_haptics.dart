import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// Centralized vibration and haptic feedback utility powered by `vibration: ^3.2.1`.
class AppHaptics {
  AppHaptics._();

  /// Master switch to enable or disable all haptic vibrations dynamically.
  static bool enabled = true;

  /// Triggered on validation errors or failed actions (distinct double-buzz pattern).
  static Future<void> error() async {
    if (!enabled) return;
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(
          pattern: [0, 80, 60, 120],
          intensities: [0, 255, 0, 255],
        );
        return;
      }
    } catch (_) {}
    await HapticFeedback.heavyImpact();
  }

  /// Triggered on successful actions (login success, registration, order complete).
  static Future<void> success() async {
    if (!enabled) return;
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: 70, amplitude: 180);
        return;
      }
    } catch (_) {}
    await HapticFeedback.mediumImpact();
  }

  /// Triggered on button clicks and interactive taps.
  static Future<void> buttonPress() async {
    if (!enabled) return;
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: 25, amplitude: 100);
        return;
      }
    } catch (_) {}
    await HapticFeedback.lightImpact();
  }

  /// Triggered on page switches, tab switches, and chip selections.
  static Future<void> selection() async {
    if (!enabled) return;
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: 15, amplitude: 60);
        return;
      }
    } catch (_) {}
    await HapticFeedback.selectionClick();
  }

  /// Trigger custom vibration duration & amplitude.
  static Future<void> custom({int duration = 100, int amplitude = -1}) async {
    if (!enabled) return;
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: duration, amplitude: amplitude);
        return;
      }
    } catch (_) {}
    await HapticFeedback.mediumImpact();
  }
}


