import 'package:flutter_riverpod/flutter_riverpod.dart';

final displayResult =
    StateNotifierProvider<DisplayResult, bool>((ref) {
  return DisplayResult();
});

class DisplayResult extends StateNotifier<bool> {
  DisplayResult() : super(false);

  void setId(bool p) {
    state = p;
  }
}
