import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../../domain/entities/scan_feedback.dart';
import '../../domain/entities/scan_mode.dart';
import '../controllers/scanner_controller.dart';
import '../widgets/face_scan_view.dart';
import '../widgets/fingerprint_scan_view.dart';
import '../widgets/qr_scanner_view.dart';
import '../widgets/scan_method_tile.dart';

class AttendanceScannerPage extends StatelessWidget {
  const AttendanceScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScannerController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Transport Tracking & Attendance'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    ScanMethodTile(
                      icon: Icons.qr_code,
                      label: 'QR',
                      selected: controller.currentMode.value == ScanMode.qr,
                      onTap: () => controller.switchMode(ScanMode.qr),
                    ),
                    const SizedBox(width: 12),
                    ScanMethodTile(
                      icon: Icons.face,
                      label: 'Face',
                      selected: controller.currentMode.value == ScanMode.face,
                      onTap: () => controller.switchMode(ScanMode.face),
                    ),
                    const SizedBox(width: 12),
                    ScanMethodTile(
                      icon: Icons.fingerprint,
                      label: 'Finger',
                      selected:
                          controller.currentMode.value == ScanMode.fingerprint,
                      onTap: () => controller.switchMode(ScanMode.fingerprint),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.modeLabel,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                switch (controller.currentMode.value) {
                  case ScanMode.face:
                    return FaceScanView(controller: controller);
                  case ScanMode.fingerprint:
                    return FingerprintScanView(controller: controller);
                  case ScanMode.qr:
                    return QrScannerView(controller: controller);
                }
              }),
              const SizedBox(height: 22),
              Obx(
                () => Text(
                  controller.statusMessage.value,
                  style: TextStyle(
                    color: controller.scanState.value == ScanState.success
                        ? AppColors.success
                        : controller.scanState.value == ScanState.failure
                        ? AppColors.error
                        : AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Obx(
                () => Row(
                  children: [
                    if (controller.currentMode.value == ScanMode.qr)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.toggleFlash,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.card,
                            foregroundColor: AppColors.textPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: Icon(
                            controller.isFlashOn.value
                                ? Icons.flash_off
                                : Icons.flash_on,
                          ),
                          label: Text(
                            controller.isFlashOn.value
                                ? 'Flash off'
                                : 'Flashlight',
                          ),
                        ),
                      ),
                    if (controller.currentMode.value == ScanMode.qr)
                      const SizedBox(width: 12),
                    Expanded(
                      flex: controller.currentMode.value == ScanMode.qr ? 2 : 1,
                      child: ElevatedButton(
                        onPressed: controller.currentMode.value == ScanMode.qr
                            ? null
                            : controller.currentMode.value == ScanMode.face
                            ? controller.checkFace
                            : controller.scanFingerprint,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Text(
                          controller.currentMode.value == ScanMode.qr
                              ? 'Waiting for QR'
                              : controller.actionLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
