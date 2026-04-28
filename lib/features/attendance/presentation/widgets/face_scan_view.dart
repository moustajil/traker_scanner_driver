import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/colors.dart';
import '../controllers/scanner_controller.dart';

class FaceScanView extends StatelessWidget {
  const FaceScanView({super.key, required this.controller});

  final ScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              height: 360,
              width: double.infinity,
              child: MobileScanner(
                controller: controller.scannerController,
                onDetect: (_) {},
              ),
            ),
          ),
          const Positioned.fill(child: _FaceGuide()),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(140),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                controller.statusMessage.value,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaceGuide extends StatelessWidget {
  const _FaceGuide();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.secondary, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withAlpha(90),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withAlpha(15),
            ),
          ),
        ),
      ),
    );
  }
}
