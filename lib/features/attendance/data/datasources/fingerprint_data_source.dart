import '../../domain/entities/scan_feedback.dart';

class FingerprintDataSource {
  Future<ScanFeedback> scanFingerprint() async {
    await Future.delayed(const Duration(seconds: 1));

    return const ScanFeedback(
      state: ScanState.success,
      message: 'Fingerprint recognized',
      result: 'SecuGen ID: A1B2C3',
    );
  }
}
