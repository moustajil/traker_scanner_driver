import 'package:flutter/services.dart';

class SystemFeedbackDataSource {
  Future<void> vibrate() async {
    try {
      await HapticFeedback.vibrate();
    } catch (_) {
      // Ignore platform failures.
    }
  }

  Future<void> playSuccessSound() async {
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {
      // Ignore platform sound failures.
    }
  }
}
