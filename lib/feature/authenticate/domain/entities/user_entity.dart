// "_id": "66fb6b126be758e00612f62c",
// "username": "Ben Tran",
// "email": "bentran@gmail.com",
// "avatar": "https://bit.ly/4cWua0j",
// "bio": "My name is Ben Tran. I am a software engineer. I have been working in the software industry for 5 years. I have experience in developing mobile applications using Flutter, Swift, and Java. I also have experience in developing web applications using NodeJS and Python. I am passionate about technology and always eager to learn new things.",
// "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2ZmI2YjEyNmJlNzU4ZTAwNjEyZjYyYyIsImlhdCI6MTcyODI5NDI2NCwiZXhwIjoxNzI4MzgwNjY0fQ.C2Fb2u7eE7QTH7GN9iGckZEBdu4bK8u8UtXeeXsixGM",
// "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2ZmI2YjEyNmJlNzU4ZTAwNjEyZjYyYyIsImlhdCI6MTcyODI5NDI2NCwiZXhwIjoxNzI4ODk5MDY0fQ.I6VtKqvZpshjPlqQKWYoc0ow86iyO02fEll4vhb7U4s"

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String avatar;
  final String bio;
  final String token;
  final String refreshToken;

  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.bio,
    required this.token,
    required this.refreshToken,
  });

  static const empty = UserEntity(
    id: '',
    username: '',
    email: '',
    avatar: '',
    bio: '',
    token: '',
    refreshToken: '',
  );

  @override
  String toString() {
    return 'UserEntity{id: $id, username: $username, email: $email, avatar: $avatar, bio: $bio, token: $token, refreshToken: $refreshToken}';
  }

  @override
  List<Object?> get props =>
      [id, username, email, avatar, bio, token, refreshToken];
}
