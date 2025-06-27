import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShouldSetupProvider extends StateNotifier<bool> {
  ShouldSetupProvider() : super(true);

  void setShouldSetup() {
    state = false;
  }
}

final shouldSetupProvider = StateNotifierProvider<ShouldSetupProvider, bool>((
  ref,
) {
  return ShouldSetupProvider();
});
