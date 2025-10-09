import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/class/item.dart';

class CautionNotifier extends StateNotifier<TextEditingController> {
  CautionNotifier() : super(TextEditingController());

  void setCaution(String caution) {
    state.value = state.value.copyWith(
      text: caution,
      selection: TextSelection.fromPosition(
        TextPosition(offset: caution.length),
      ),
    );
  }

  void setCautionFromSelected(Map<Item, int> selected) {
    double total = 0;
    selected.forEach((key, value) {
      total += key.caution * value;
    });
    final caution = "${total.toStringAsFixed(2)} €";
    state.value = state.value.copyWith(
      text: caution,
      selection: TextSelection.fromPosition(
        TextPosition(offset: caution.length),
      ),
    );
  }
}

final cautionProvider =
    StateNotifierProvider<CautionNotifier, TextEditingController>((ref) {
      return CautionNotifier();
    });
