import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductDetailEvent extends ProductDetailEvent {
  final int id;

  const FetchProductDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}
