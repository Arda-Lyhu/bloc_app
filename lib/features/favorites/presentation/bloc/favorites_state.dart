import 'package:equatable/equatable.dart';
import '../../../products/domain/entities/product.dart';

class FavoritesState extends Equatable {
  final List<Product> favorites;

  const FavoritesState({this.favorites = const []});

  @override
  List<Object?> get props => [favorites];
}
