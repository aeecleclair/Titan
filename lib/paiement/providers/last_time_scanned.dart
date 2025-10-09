import 'package:hooks_riverpod/hooks_riverpod.dart';

class LastTimeScannedNotifier extends StateNotifier<DateTime?> {
  LastTimeScannedNotifier() : super(null);

  void updateLastTimeScanned(DateTime lastTimeScanned) {
    state = lastTimeScanned;
  }

  void clearLastTimeScanned() {
    state = null;
  }
}

final lastTimeScannedProvider =
    StateNotifierProvider<LastTimeScannedNotifier, DateTime?>((ref) {
      return LastTimeScannedNotifier();
    });
