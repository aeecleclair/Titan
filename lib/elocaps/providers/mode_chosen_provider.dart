import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/elocaps/class/caps_mode.dart';

class ModeNotifier extends StateNotifier<CapsMode> {
  ModeNotifier() : super(CapsMode.single);

  void setMode(CapsMode mode) {
    state = mode;
  }
}

final modeChosenProvider = StateNotifierProvider<ModeNotifier, CapsMode>((ref) {
  return ModeNotifier();
});
