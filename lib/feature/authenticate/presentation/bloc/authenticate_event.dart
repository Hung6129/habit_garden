part of 'authenticate_bloc.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailAndPassword extends AuthenticateEvent {
  final SignInParam signInParam;
  final bool isRememberMe;

  const SignInWithEmailAndPassword({
    required this.signInParam,
    required this.isRememberMe,
  });

  @override
  List<Object> get props => [
        signInParam,
        isRememberMe,
      ];
}

class SignUpWithEmailAndPassword extends AuthenticateEvent {
  final SignUpParam signUpParam;

  const SignUpWithEmailAndPassword({
    required this.signUpParam,
  });

  @override
  List<Object> get props => [signUpParam];
}
