import 'package:app_scale/features/products/domain/entities/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final String size;
  final String color;

  const CartItem({
    required this.product,
    this.quantity = 1,
    this.size = 'M',
    this.color = 'Black',
  });

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? size,
    String? color,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  double get totalPrice => product.price * quantity;
}
