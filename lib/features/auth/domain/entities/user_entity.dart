class UserEntity {
  final int id;
  final String username;
  final String email;
  final String password;
  final String avatar;

  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.avatar,
    required this.password,
  });
}
