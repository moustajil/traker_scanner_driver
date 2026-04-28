import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/colors.dart';
import '../../domain/entities/scan_feedback.dart';
import '../controllers/scanner_controller.dart';

class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key, required this.controller});

  final ScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.scanState.value == ScanState.permissionDenied) {
        return Center(
          child: Text(
            controller.statusMessage.value,
            style: const TextStyle(color: AppColors.error, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              height: 360,
              width: double.infinity,
              child: MobileScanner(
                controller: controller.scannerController,
                onDetect: controller.onQrDetected,
              ),
            ),
          ),
          const Positioned.fill(child: _QrOverlay()),
        ],
      );
    });
  }
}

class _QrOverlay extends StatelessWidget {
  const _QrOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withAlpha(90)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            height: 220,
            width: 220,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.accent, width: 3),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      ),
    );
  }
}
