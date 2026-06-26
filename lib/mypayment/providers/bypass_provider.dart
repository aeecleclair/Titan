import 'package:hooks_riverpod/hooks_riverpod.dart';

class BypassNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setBypass(bool bypass) {
    state = bypass;
  }
}

final bypassProvider = NotifierProvider<BypassNotifier, bool>(
  BypassNotifier.new,
);
