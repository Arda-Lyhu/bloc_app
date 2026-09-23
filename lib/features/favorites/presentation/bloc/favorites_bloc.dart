import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  void _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) {
    final exists = state.favorites.any((p) => p.id == event.product.id);
    if (exists) {
      emit(FavoritesState(
        favorites:
            state.favorites.where((p) => p.id != event.product.id).toList(),
      ));
    } else {
      emit(FavoritesState(
        favorites: [
          ...state.favorites,
          event.product.copyWith(isFavorite: true)
        ],
      ));
    }
  }
}
