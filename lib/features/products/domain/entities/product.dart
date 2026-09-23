class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String brand;
  final double price;
  final double discountPercentage;
  final double oldPrice;
  final double rating;
  final int ratingCount;
  final String thumbnail;
  final List<String> images;
  final bool isNew;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.brand = 'Dorothy Perkins',
    required this.price,
    this.discountPercentage = 0.0,
    this.oldPrice = 0.0,
    required this.rating,
    this.ratingCount = 10,
    required this.thumbnail,
    required this.images,
    this.isNew = false,
    this.isFavorite = false,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? brand,
    double? price,
    double? discountPercentage,
    double? oldPrice,
    double? rating,
    int? ratingCount,
    String? thumbnail,
    List<String>? images,
    bool? isNew,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      isNew: isNew ?? this.isNew,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
