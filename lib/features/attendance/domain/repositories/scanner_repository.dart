import '../entities/scan_feedback.dart';

abstract class ScannerRepository {
  Future<bool> requestCameraPermission({required bool front});
  Future<ScanFeedback> detectFace();
  Future<ScanFeedback> scanFingerprint();
  Future<void> vibrate();
  Future<void> playSuccessSound();
}
