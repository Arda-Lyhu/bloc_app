import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'core/core.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🚀 Single Master Control Cockpit:
  // Control branding, backend API, haptics, logging, onboarding, & theme in 1 place.
  AppConfig.init(
    appName: 'APP SCALE',
    environment: AppEnvironment.dev,
    customBaseUrl: 'https://dummyjson.com',
    enableLogging: true,
    enableHaptics: true,
    enableOnboarding: true,
    primaryColor: const Color(0xFFDB3022),
  );

  Bloc.observer = const AppBlocObserver();

  // Wire up all dependencies before the app starts.
  await configureDependencies();

  runApp(const App());
}
