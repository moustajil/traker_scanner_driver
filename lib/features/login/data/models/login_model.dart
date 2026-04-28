import '../../domain/entities/login_credentials.dart';

class LoginModel extends LoginCredentials {
  const LoginModel({required super.email, required super.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }
}
