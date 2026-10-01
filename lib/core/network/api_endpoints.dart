class ApiEndpoints {
  static const String _base = '/api';

  static const String login = '$_base/auth/login';
  static const String register = '$_base/auth/register';
  static const String logout = '$_base/auth/logout';
  static const String userProfile = '$_base/auth/me';

  static const String products = '$_base/products';
  static String productDetail(int id) => '$_base/products/$id';
  static const String searchProducts = '$_base/products/search';
  static const String categories = '$_base/products/categories';
}
