import 'package:get_it/get_it.dart';
import 'modules/auth_module.dart';
import 'modules/cart_favorites_module.dart';
import 'modules/network_module.dart';
import 'modules/product_module.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Call this once in [main] before [runApp].
///
/// To add a new feature:
///   1. Create `lib/core/di/modules/your_feature_module.dart`
///   2. Call `registerYourFeatureModule(sl)` below
Future<void> configureDependencies() async {
  // ── Core ──────────────────────────────────────────────
  registerNetworkModule(sl);

  // ── Features ──────────────────────────────────────────
  registerProductModule(sl);
  registerAuthModule(sl);
  registerCartFavoritesModule(sl);
}
