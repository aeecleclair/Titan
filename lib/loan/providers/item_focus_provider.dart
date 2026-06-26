import 'package:hooks_riverpod/hooks_riverpod.dart';

class FocusNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setFocus(bool value) {
    state = value;
  }
}

final itemFocusProvider = NotifierProvider<FocusNotifier, bool>(
  FocusNotifier.new,
);
