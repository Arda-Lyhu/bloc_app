/// Simple in-memory token store.
///
/// Call [save] after a successful login and [clear] on logout.
/// The Dio interceptor reads [token] on every request.
class TokenStore {
  TokenStore._();

  static final TokenStore instance = TokenStore._();

  String? _token;

  /// The current access token, or `null` if the user is not logged in.
  String? get token => _token;

  /// Persist the access token returned by the login endpoint.
  void save(String token) => _token = token;

  /// Remove the token on logout.
  void clear() => _token = null;
}
