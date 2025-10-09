import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantityNotifier extends StateNotifier<TextEditingController> {
  QuantityNotifier() : super(TextEditingController());

  void setQuantity(int quantity) {
    state.value = state.value.copyWith(
      text: quantity.toString(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: quantity.toString().length),
      ),
    );
  }
}

final quantityProvider =
    StateNotifierProvider<QuantityNotifier, TextEditingController>((ref) {
      return QuantityNotifier();
    });
