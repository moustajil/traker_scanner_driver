import '../../domain/entities/scan_feedback.dart';

class FaceScanDataSource {
  Future<ScanFeedback> detectFace() async {
    await Future.delayed(const Duration(milliseconds: 900));

    return const ScanFeedback(
      state: ScanState.success,
      message: 'Face detected',
    );
  }
}
