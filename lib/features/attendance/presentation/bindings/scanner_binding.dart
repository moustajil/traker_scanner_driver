import 'package:get/get.dart';

import '../../data/datasources/camera_permission_data_source.dart';
import '../../data/datasources/face_scan_data_source.dart';
import '../../data/datasources/fingerprint_data_source.dart';
import '../../data/datasources/system_feedback_data_source.dart';
import '../../data/repositories/scanner_repository_impl.dart';
import '../../domain/repositories/scanner_repository.dart';
import '../../domain/usecases/scanner_usecase.dart';
import '../controllers/scanner_controller.dart';

class ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraPermissionDataSource>(() => CameraPermissionDataSource());
    Get.lazyPut<FaceScanDataSource>(() => FaceScanDataSource());
    Get.lazyPut<FingerprintDataSource>(() => FingerprintDataSource());
    Get.lazyPut<SystemFeedbackDataSource>(() => SystemFeedbackDataSource());
    Get.lazyPut<ScannerRepository>(
      () => ScannerRepositoryImpl(
        permissionDataSource: Get.find(),
        faceScanDataSource: Get.find(),
        fingerprintDataSource: Get.find(),
        systemFeedbackDataSource: Get.find(),
      ),
    );
    Get.lazyPut<ScannerUseCase>(() => ScannerUseCase(Get.find()));
    Get.lazyPut<ScannerController>(
      () => ScannerController(useCase: Get.find()),
    );
  }
}
