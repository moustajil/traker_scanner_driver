import 'package:permission_handler/permission_handler.dart';

class CameraPermissionDataSource {
  Future<bool> requestCameraPermission({required bool front}) async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
}
