import 'package:equatable/equatable.dart';
import '../../../products/domain/entities/product.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> saleProducts;
  final List<Product> newProducts;

  const HomeLoaded({
    required this.saleProducts,
    required this.newProducts,
  });

  @override
  List<Object?> get props => [saleProducts, newProducts];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
