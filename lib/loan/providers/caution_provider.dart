import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CautionNotifier extends StateNotifier<TextEditingController> {
  CautionNotifier() : super(TextEditingController());

  void setCaution(String caution) {
    state.value = state.value.copyWith(
      text: caution,
      selection: TextSelection.fromPosition(
          TextPosition(offset: caution.length)),
    );
  }
}

final cautionProvider = StateNotifierProvider<CautionNotifier, TextEditingController>((ref) {
  return CautionNotifier();
});
