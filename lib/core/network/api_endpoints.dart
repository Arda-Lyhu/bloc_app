class ApiEndpoints {
  static const String products = '/products';
  static String productDetail(int id) => '/products/$id';
  static const String searchProducts = '/products/search';
  static const String categories = '/products/categories';
  static const String login = '/auth/login';
  static const String userProfile = '/auth/me';
}
