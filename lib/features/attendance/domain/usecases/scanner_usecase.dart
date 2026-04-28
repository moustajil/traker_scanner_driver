import '../entities/scan_feedback.dart';
import '../repositories/scanner_repository.dart';

class ScannerUseCase {
  final ScannerRepository repository;

  ScannerUseCase(this.repository);

  Future<bool> requestCameraPermission({required bool front}) {
    return repository.requestCameraPermission(front: front);
  }

  Future<ScanFeedback> detectFace() {
    return repository.detectFace();
  }

  Future<ScanFeedback> scanFingerprint() {
    return repository.scanFingerprint();
  }

  Future<void> vibrate() {
    return repository.vibrate();
  }

  Future<void> playSuccessSound() {
    return repository.playSuccessSound();
  }
}
