import 'package:get_it/get_it.dart';
import '../../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../../features/favorites/presentation/bloc/favorites_bloc.dart';

/// Registers cart and favorites dependencies.
/// These have no remote dependencies so they are kept together.
void registerCartFavoritesModule(GetIt sl) {
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => FavoritesBloc());
}
