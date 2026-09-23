import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'app/app_env.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnv.init(
    environment: AppEnvironment.dev,
    enableLogger: true,
  );
  Bloc.observer = const AppBlocObserver();

  runApp(const App());
}

// import 'package:app_scale/features/test/counter_bloc_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CounterBlocScreen(),
//     );
//   }
// }
