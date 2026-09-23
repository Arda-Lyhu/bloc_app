import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/domain/entities/product.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggleFavorite(Product product) {
    final exists = state.favorites.any((p) => p.id == product.id);
    if (exists) {
      emit(FavoritesState(
        favorites: state.favorites.where((p) => p.id != product.id).toList(),
      ));
    } else {
      emit(FavoritesState(
        favorites: [...state.favorites, product.copyWith(isFavorite: true)],
      ));
    }
  }
}
