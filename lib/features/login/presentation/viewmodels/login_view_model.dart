import 'package:flutter/foundation.dart';
import '../../domain/entities/login_credentials.dart';
import '../../domain/usecases/login_usecase.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginViewModel({required this.loginUseCase});

  LoginStatus status = LoginStatus.initial;
  String? message;

  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;

  Future<bool> login(String email, String password) async {
    status = LoginStatus.loading;
    message = null;
    notifyListeners();

    final credentials = LoginCredentials(
      email: email.trim(),
      password: password,
    );

    if (!credentials.isValidEmail) {
      status = LoginStatus.failure;
      message = 'Please enter a valid email address.';
      notifyListeners();
      return false;
    }

    if (!credentials.isValidPassword) {
      status = LoginStatus.failure;
      message = 'Password must be at least 6 characters.';
      notifyListeners();
      return false;
    }

    try {
      final success = await loginUseCase(credentials);
      if (success) {
        status = LoginStatus.success;
        message = 'Login successful.';
      } else {
        status = LoginStatus.failure;
        message = 'Invalid email or password.';
      }
      notifyListeners();
      return success;
    } catch (_) {
      status = LoginStatus.failure;
      message = 'Unable to login. Please try again.';
      notifyListeners();
      return false;
    }
  }
}
