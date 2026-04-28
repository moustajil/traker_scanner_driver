import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/login_credentials.dart';
import '../../domain/usecases/login_usecase.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginController extends GetxController {
  LoginController({required this.loginUseCase});

  final LoginUseCase loginUseCase;

  final status = LoginStatus.initial.obs;
  final message = ''.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool get isLoading => status.value == LoginStatus.loading;
  bool get isSuccess => status.value == LoginStatus.success;

  Future<void> login() async {
    Get.focusScope?.unfocus();
    status.value = LoginStatus.loading;
    message.value = '';

    final credentials = LoginCredentials(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    if (!credentials.isValidEmail) {
      status.value = LoginStatus.failure;
      message.value = 'Please enter a valid email address.';
      return;
    }

    if (!credentials.isValidPassword) {
      status.value = LoginStatus.failure;
      message.value = 'Password must be at least 6 characters.';
      return;
    }

    try {
      final success = await loginUseCase(credentials);
      if (success) {
        status.value = LoginStatus.success;
        message.value = 'Login successful.';
        Get.snackbar(
          'Success',
          'Login completed successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
        );
      } else {
        status.value = LoginStatus.failure;
        message.value = 'Invalid email or password.';
      }
    } catch (_) {
      status.value = LoginStatus.failure;
      message.value = 'Unable to login. Please try again.';
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
