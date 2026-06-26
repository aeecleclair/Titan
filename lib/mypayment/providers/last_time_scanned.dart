import 'package:hooks_riverpod/hooks_riverpod.dart';

class LastTimeScannedNotifier extends Notifier<DateTime?> {
  @override
  DateTime? build() {
    return null;
  }

  void updateLastTimeScanned(DateTime lastTimeScanned) {
    state = lastTimeScanned;
  }

  void clearLastTimeScanned() {
    state = null;
  }
}

final lastTimeScannedProvider =
    NotifierProvider<LastTimeScannedNotifier, DateTime?>(
      LastTimeScannedNotifier.new,
    );
