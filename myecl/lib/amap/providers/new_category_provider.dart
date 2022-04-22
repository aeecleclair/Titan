import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

final newCategoryProvider =
    StateNotifierProvider<NewCategoryNotifier, TextEditingController>(
  (ref) {
    return NewCategoryNotifier();
  },
);

class NewCategoryNotifier extends StateNotifier<TextEditingController> {
  NewCategoryNotifier() : super(TextEditingController());

  void setText(String txt) {
    state.text = txt;
  }
}
