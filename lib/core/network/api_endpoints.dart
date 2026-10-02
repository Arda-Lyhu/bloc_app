class ApiEndpoints {
  // DummyJSON has no /api prefix — all routes are at root level
  static const String login = '/auth/login';
  static const String register = '/users/add';
  static const String logout = '/auth/logout';
  static const String userProfile = '/auth/me';

  static const String products = '/products';
  static String productDetail(int id) => '/products/$id';
  static const String searchProducts = '/products/search';
  static const String categories = '/products/categories';
}
