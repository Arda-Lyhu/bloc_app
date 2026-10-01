import 'package:app_scale/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'route_name.dart';
import '../shell/main_shell.dart';
import '../../features/auth/presentation/screens/login/login_screen.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: RoutePath.mainShell,
  routes: [
    GoRoute(
      path: RoutePath.mainShell,
      name: RouteName.mainShell,
      builder: (context, state) => const MainShell(),
    ),
    GoRoute(
      path: RoutePath.home,
      name: RouteName.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RoutePath.productDetail,
      name: RouteName.productDetail,
      builder: (context, state) {
        final idStr = state.pathParameters['id'];
        final id = int.tryParse(idStr ?? '') ?? 0;
        return ProductDetailScreen(productId: id);
      },
    ),
    GoRoute(
      path: RoutePath.login,
      name: RouteName.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePath.categories,
      name: RouteName.categories,
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: RoutePath.search,
      name: RouteName.search,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: RoutePath.checkout,
      name: RouteName.checkout,
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: RoutePath.orders,
      name: RouteName.orders,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: RoutePath.notifications,
      name: RouteName.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: RoutePath.settings,
      name: RouteName.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
