import 'package:equatable/equatable.dart';
import '../../../products/domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final Product product;

  const AddToCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class IncrementQuantityEvent extends CartEvent {
  final int productId;

  const IncrementQuantityEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class DecrementQuantityEvent extends CartEvent {
  final int productId;

  const DecrementQuantityEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;

  const RemoveFromCartEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
