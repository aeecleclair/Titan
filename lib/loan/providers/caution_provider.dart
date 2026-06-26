import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class CautionNotifier extends Notifier<TextEditingController> {
  @override
  TextEditingController build() {
    return TextEditingController();
  }

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
      total += key.suggestedCaution * value;
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
    NotifierProvider<CautionNotifier, TextEditingController>(
      CautionNotifier.new,
    );
