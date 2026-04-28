enum ScanState { idle, scanning, success, failure, permissionDenied }

class ScanFeedback {
  final ScanState state;
  final String message;
  final String? result;

  const ScanFeedback({required this.state, required this.message, this.result});

  bool get isSuccess => state == ScanState.success;
}
