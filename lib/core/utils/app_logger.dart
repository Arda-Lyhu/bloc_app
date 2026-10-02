import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Centralised logger for the app.
///
/// Every call prints cleanly to the terminal console (`flutter run`)
/// and sends structured events to Flutter DevTools.
///
///   🟢 INFO  – general progress / lifecycle events
///   🐛 DEBUG – verbose data / state dumps (dev-only)
///   ⚠️ WARN  – recoverable oddities
///   🔴 ERROR – unhandled failures
///   🌐 NET   – HTTP request / response details
///
/// Usage:
///   AppLogger.info('UserBloc', 'Login success');
///   AppLogger.debug('HomeBloc', 'Products loaded', data: products);
///   AppLogger.error('UserBloc', 'Login failed', error: e, stackTrace: st);
///   AppLogger.network(method: 'GET', url: '/products', statusCode: 200);
class AppLogger {
  AppLogger._();

  // ─── Toggle to false in production builds ───────────────────────────────
  static bool enabled = kDebugMode;

  // ─── Level helpers ───────────────────────────────────────────────────────

  static void info(String tag, String message, {Object? data}) {
    _log('🟢 INFO ', tag, message, data: data);
  }

  static void debug(String tag, String message, {Object? data}) {
    _log('🐛 DEBUG', tag, message, data: data);
  }

  static void warn(String tag, String message, {Object? data}) {
    _log('⚠️  WARN', tag, message, data: data);
  }

  static void error(
    String tag,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!enabled) return;
    final buffer = StringBuffer();
    buffer.writeln('╔════════════════════════════════════════');
    buffer.writeln('║ 🔴 ERROR  [$tag]');
    buffer.writeln('║ $message');
    if (error != null) buffer.writeln('║ ↳ $error');
    if (stackTrace != null) buffer.writeln('║ StackTrace:\n$stackTrace');
    buffer.write('╚════════════════════════════════════════');
    final logText = buffer.toString();
    debugPrint(logText);
    developer.log(
      logText,
      name: tag,
      error: error,
      stackTrace: stackTrace,
      level: 1000, // severe
    );
  }

  /// Pretty-prints an HTTP event (request or response).
  ///
  /// [statusCode] is null for outgoing requests.
  static void network({
    required String method,
    required String url,
    int? statusCode,
    Object? body,
    Object? response,
    Object? error,
    Map<String, dynamic>? headers,
  }) {
    if (!enabled) return;
    final isError = error != null || (statusCode != null && statusCode >= 400);
    final icon = isError ? '🔴' : (statusCode == null ? '📤' : '📥');
    final buffer = StringBuffer();
    buffer.writeln('┌─ 🌐 NET ────────────────────────────────');
    buffer.writeln('│ $icon $method  ${statusCode != null ? '[$statusCode]' : ''}  $url');
    if (headers != null) buffer.writeln('│ Headers : $headers');
    if (body != null) buffer.writeln('│ Body    : $body');
    if (response != null) buffer.writeln('│ Response: $response');
    if (error != null) buffer.writeln('│ Error   : $error');
    buffer.write('└─────────────────────────────────────────');
    final logText = buffer.toString();
    debugPrint(logText);
    developer.log(logText, name: 'NET');
  }

  // ─── Internal ────────────────────────────────────────────────────────────

  static void _log(String level, String tag, String message, {Object? data}) {
    if (!enabled) return;
    final buffer = StringBuffer();
    buffer.write('$level [$tag] $message');
    if (data != null) buffer.write('\n          ↳ $data');
    final logText = buffer.toString();
    debugPrint(logText);
    developer.log(logText, name: tag);
  }
}
