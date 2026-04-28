import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../domain/entities/scan_feedback.dart';
import '../controllers/scanner_controller.dart';

class FingerprintScanView extends StatelessWidget {
  const FingerprintScanView({super.key, required this.controller});

  final ScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.fingerprint, size: 92, color: Color(0xFF1E3A8A)),
              const SizedBox(height: 20),
              Text(
                controller.statusMessage.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: controller.scanState.value == ScanState.success
                      ? AppColors.success
                      : controller.scanState.value == ScanState.failure
                      ? AppColors.error
                      : AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (controller.scanResult.value != null) ...[
                const SizedBox(height: 18),
                Text(
                  controller.scanResult.value!,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
