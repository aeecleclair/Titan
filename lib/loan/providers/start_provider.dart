import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartNotifier extends StateNotifier<TextEditingController> {
  StartNotifier() : super(TextEditingController());

  void setStart(String start) {
    state.value = state.value.copyWith(
      text: start,
      selection: TextSelection.fromPosition(TextPosition(offset: start.length)),
    );
  }
}

final startProvider =
    StateNotifierProvider<StartNotifier, TextEditingController>((ref) {
  return StartNotifier();
});
