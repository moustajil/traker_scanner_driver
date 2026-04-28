import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../attendance/presentation/bindings/scanner_binding.dart';
import '../../../attendance/presentation/pages/attendance_scanner_page.dart';
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

    // Simulate successful login - accept anything for now
    status.value = LoginStatus.success;
    message.value = 'Login successful.';
    Get.snackbar(
      'Success',
      'Login completed successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
    );

    // Navigate to attendance scanner after successful login
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Brief delay for user feedback
    Get.offAll(() => const AttendanceScannerPage(), binding: ScannerBinding());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
