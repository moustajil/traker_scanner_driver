import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../domain/entities/scan_feedback.dart';
import '../../domain/entities/scan_mode.dart';
import '../../domain/usecases/scanner_usecase.dart';

class ScannerController extends GetxController {
  ScannerController({required this.useCase});

  final ScannerUseCase useCase;

  final currentMode = ScanMode.qr.obs;
  final scanState = ScanState.idle.obs;
  final statusMessage = 'Ready to scan'.obs;
  final scanResult = RxnString();
  final isFlashOn = false.obs;

  MobileScannerController? scannerController;

  @override
  void onInit() {
    super.onInit();
    _prepareScanner(CameraFacing.back);
    _checkQrPermissions();
  }

  void _prepareScanner(CameraFacing facing) {
    scannerController?.dispose();
    scannerController = MobileScannerController(
      facing: facing,
      detectionSpeed: DetectionSpeed.noDuplicates,
      torchEnabled: false,
    );
  }

  Future<void> _checkQrPermissions() async {
    final granted = await useCase.requestCameraPermission(front: false);
    if (!granted) {
      scanState.value = ScanState.permissionDenied;
      statusMessage.value = 'Camera access is required for QR scanning.';
    }
  }

  void switchMode(ScanMode mode) {
    if (currentMode.value == mode) return;

    currentMode.value = mode;
    scanResult.value = null;
    isFlashOn.value = false;

    if (mode == ScanMode.qr) {
      _prepareScanner(CameraFacing.back);
      _checkQrPermissions();
      statusMessage.value = 'Point the camera at a QR code.';
    } else if (mode == ScanMode.face) {
      _prepareScanner(CameraFacing.front);
      statusMessage.value = 'Align your face inside the guide.';
    } else {
      statusMessage.value = 'Tap the button to start fingerprint scan.';
    }
  }

  void onQrDetected(BarcodeCapture capture) async {
    if (scanState.value == ScanState.scanning) return;

    final barcode = capture.barcodes.first;
    final value = barcode.rawValue;
    if (value == null || value.isEmpty) return;

    scanState.value = ScanState.scanning;
    statusMessage.value = 'QR detected. Processing...';

    await useCase.vibrate();
    await useCase.playSuccessSound();

    scanResult.value = value;
    scanState.value = ScanState.success;
    statusMessage.value = 'QR scan successful';

    if (scannerController?.torchState.value == TorchState.on) {
      await scannerController?.toggleTorch();
      isFlashOn.value = false;
    }
  }

  Future<void> toggleFlash() async {
    if (currentMode.value != ScanMode.qr) return;
    await scannerController?.toggleTorch();
    isFlashOn.value = !isFlashOn.value;
  }

  Future<void> checkFace() async {
    scanState.value = ScanState.scanning;
    statusMessage.value = 'Detecting face...';

    final feedback = await useCase.detectFace();
    await useCase.vibrate();

    scanState.value = feedback.state;
    statusMessage.value = feedback.message;
    if (feedback.isSuccess) {
      await useCase.playSuccessSound();
    }
  }

  Future<void> scanFingerprint() async {
    scanState.value = ScanState.scanning;
    statusMessage.value = 'Place your finger on the reader.';

    final feedback = await useCase.scanFingerprint();
    await useCase.vibrate();

    scanState.value = feedback.state;
    statusMessage.value = feedback.message;
    scanResult.value = feedback.result;

    if (feedback.isSuccess) {
      await useCase.playSuccessSound();
    }
  }

  String get modeLabel {
    switch (currentMode.value) {
      case ScanMode.qr:
        return 'QR Code Scan';
      case ScanMode.face:
        return 'Face Scan';
      case ScanMode.fingerprint:
        return 'Fingerprint Scan';
    }
  }

  String get actionLabel {
    switch (currentMode.value) {
      case ScanMode.qr:
        return 'Start QR Scan';
      case ScanMode.face:
        return 'Check Face';
      case ScanMode.fingerprint:
        return 'Scan Fingerprint';
    }
  }

  @override
  void onClose() {
    scannerController?.dispose();
    super.onClose();
  }
}
