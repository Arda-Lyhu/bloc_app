import 'package:equatable/equatable.dart';
import '../../../products/domain/entities/product.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final Product product;

  const ToggleFavoriteEvent(this.product);

  @override
  List<Object?> get props => [product];
}
