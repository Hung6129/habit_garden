import 'package:habit_garden/feature/authenticate/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.avatar,
    required super.bio,
    required super.token,
    required super.refreshToken,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? avatar,
    String? bio,
    String? token,
    String? refreshToken,
  }) {
    return UserModel(
      id: id ?? super.id,
      username: username ?? super.username,
      email: email ?? super.email,
      avatar: avatar ?? super.avatar,
      bio: bio ?? super.bio,
      token: token ?? super.token,
      refreshToken: refreshToken ?? super.refreshToken,
    );
  }

  static empty() {
    return const UserModel(
      id: '',
      username: '',
      email: '',
      avatar: '',
      bio: '',
      token: '',
      refreshToken: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      avatar: json['avatar'],
      bio: json['bio'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }
}
