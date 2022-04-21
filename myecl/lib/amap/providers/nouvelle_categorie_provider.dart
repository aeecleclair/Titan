import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

final nouvelleCategorieProvider =
    StateNotifierProvider<NouvelleCategorie, TextEditingController>(
  (ref) {
    return NouvelleCategorie();
  },
);

class NouvelleCategorie extends StateNotifier<TextEditingController> {
  NouvelleCategorie() : super(TextEditingController());

  void setText(String txt) {
    state.text = txt;
  }
}
