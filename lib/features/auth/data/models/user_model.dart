import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String accessToken;

  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.password,
    required super.avatar,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      avatar: (json['image'] ?? json['avatar']) as String? ?? '',
      accessToken: (json['accessToken'] ?? json['token']) as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'image': avatar,
      'accessToken': accessToken,
    };
  }

  UserModel copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? avatar,
    String? accessToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

