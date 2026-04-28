import '../../domain/entities/scan_feedback.dart';
import '../../domain/repositories/scanner_repository.dart';
import '../datasources/camera_permission_data_source.dart';
import '../datasources/face_scan_data_source.dart';
import '../datasources/fingerprint_data_source.dart';
import '../datasources/system_feedback_data_source.dart';

class ScannerRepositoryImpl implements ScannerRepository {
  final CameraPermissionDataSource permissionDataSource;
  final FaceScanDataSource faceScanDataSource;
  final FingerprintDataSource fingerprintDataSource;
  final SystemFeedbackDataSource systemFeedbackDataSource;

  ScannerRepositoryImpl({
    required this.permissionDataSource,
    required this.faceScanDataSource,
    required this.fingerprintDataSource,
    required this.systemFeedbackDataSource,
  });

  @override
  Future<bool> requestCameraPermission({required bool front}) {
    return permissionDataSource.requestCameraPermission(front: front);
  }

  @override
  Future<ScanFeedback> detectFace() {
    return faceScanDataSource.detectFace();
  }

  @override
  Future<ScanFeedback> scanFingerprint() {
    return fingerprintDataSource.scanFingerprint();
  }

  @override
  Future<void> vibrate() {
    return systemFeedbackDataSource.vibrate();
  }

  @override
  Future<void> playSuccessSound() {
    return systemFeedbackDataSource.playSuccessSound();
  }
}
