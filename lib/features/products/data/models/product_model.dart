import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    super.brand,
    required super.price,
    super.discountPercentage,
    super.oldPrice,
    required super.rating,
    super.ratingCount,
    required super.thumbnail,
    required super.images,
    super.isNew,
    super.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] as num?)?.toDouble() ?? 0.0;
    final discountPercentage =
        (json['discountPercentage'] as num?)?.toDouble() ?? 0.0;
    final oldPrice = discountPercentage > 0
        ? (price / (1 - (discountPercentage / 100)))
        : price;

    final id = json['id'] as int? ?? 0;
    final isNew = id % 2 == 0; // Deterministic toggle for mockup demo

    return ProductModel(
      id: id,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      brand: json['brand'] as String? ?? 'Sitlly',
      price: price,
      discountPercentage: discountPercentage,
      oldPrice: oldPrice,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      ratingCount: (json['stock'] as int?) ?? 10,
      thumbnail: json['thumbnail'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isNew: isNew,
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'brand': brand,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'thumbnail': thumbnail,
      'images': images,
    };
  }
}
