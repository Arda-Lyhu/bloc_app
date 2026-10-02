import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/core.dart';
import '../core/di/injection_container.dart';
import '../features/auth/presentation/bloc/user_bloc.dart';
import '../features/cart/presentation/bloc/cart_bloc.dart';
import '../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../features/home/presentation/bloc/home_bloc.dart';
import '../features/home/presentation/bloc/home_event.dart';
import '../features/products/presentation/bloc/product/products_bloc.dart';
import '../features/products/presentation/bloc/product/products_event.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (_) => sl<ProductsBloc>()..add(FetchProductsEvent()),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => sl<HomeBloc>()..add(FetchHomeFeedEvent()),
        ),
        BlocProvider<CartBloc>(
          create: (_) => sl<CartBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => sl<FavoritesBloc>(),
        ),
        BlocProvider<UserBloc>(
          create: (_) => sl<UserBloc>(),
        ),
      ],
      child: ValueListenableBuilder<AppLanguage>(
        valueListenable: LanguageController.instance.currentLanguage,
        builder: (context, lang, _) {
          return MaterialApp.router(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            locale: lang.locale,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
