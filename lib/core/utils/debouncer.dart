import 'dart:async';
import 'package:flutter/foundation.dart';

/// A utility to delay function execution until a pause in rapid calls (e.g. search bar typing).
class Debouncer {
  Debouncer({Duration? delay, int? milliseconds})
      : delay = delay ?? Duration(milliseconds: milliseconds ?? 400);

  final Duration delay;
  Timer? _timer;

  /// Runs [action] after [delay] has elapsed without new calls.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancels any active pending debounce timer.
  void cancel() {
    _timer?.cancel();
  }

  /// Disposes the debouncer.
  void dispose() {
    _timer?.cancel();
  }
}

/// A utility to prevent duplicate rapid button taps within a short window.
class Throttler {
  Throttler({Duration? throttleDuration, int? milliseconds})
      : throttleDuration =
            throttleDuration ?? Duration(milliseconds: milliseconds ?? 600);

  final Duration throttleDuration;
  DateTime? _lastExecution;

  /// Runs [action] only if [throttleDuration] has passed since last execution.
  void run(VoidCallback action) {
    final now = DateTime.now();
    if (_lastExecution == null ||
        now.difference(_lastExecution!) > throttleDuration) {
      _lastExecution = now;
      action();
    }
  }
}
