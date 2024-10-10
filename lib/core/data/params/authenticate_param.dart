class SignInParam {
  final String email;
  final String password;

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  SignInParam({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

// {
//     "username":"Hung Tran",
//     "email":"hungtran@gmail.com",
//     "password":"123456789"
// }
class SignUpParam {
  final String username;
  final String email;
  final String password;

  SignUpParam({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
