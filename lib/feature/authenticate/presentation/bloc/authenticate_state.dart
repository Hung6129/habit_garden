part of 'authenticate_bloc.dart';

enum AuthenticateStatus {
  initial,
  loading,
  success,
  failure,
}

class AuthenticateState extends Equatable {
  final AuthenticateStatus status;
  final String? message;
  final UserEntity user;
  final bool? isRememberMe;

  const AuthenticateState({
    this.status = AuthenticateStatus.initial,
    this.user = UserEntity.empty,
    this.message = '',
    this.isRememberMe = false,
  });

  const AuthenticateState.success(
    this.user,
    this.isRememberMe,
  )   : status = AuthenticateStatus.success,
        message = '';

  const AuthenticateState.failure(
    this.message, {
    this.isRememberMe = false,
    UserEntity? user,
  })  : status = AuthenticateStatus.failure,
        user = user ?? UserEntity.empty;

  AuthenticateState copyWith({
    AuthenticateStatus? status,
    String? message,
    UserEntity? user,
    bool? isRememberMe,
  }) {
    return AuthenticateState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }

  @override
  List<Object> get props => [
        status,
        message ?? '',
        user,
        isRememberMe ?? false,
      ];
}
