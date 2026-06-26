import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShouldSetupProvider extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  void setShouldSetup() {
    state = false;
  }
}

final shouldSetupProvider = NotifierProvider<ShouldSetupProvider, bool>(
  ShouldSetupProvider.new,
);
