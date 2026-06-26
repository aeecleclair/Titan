import 'package:hooks_riverpod/hooks_riverpod.dart';

class FocusNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setFocus(bool value) {
    state = value;
  }
}

final focusProvider = NotifierProvider<FocusNotifier, bool>(FocusNotifier.new);
