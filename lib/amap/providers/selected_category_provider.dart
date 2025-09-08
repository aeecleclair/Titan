import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider =
    StateNotifierProvider.family<SelectedCategoryNotifier, String, String>((
      ref,
      txt,
    ) {
      return SelectedCategoryNotifier(txt);
    });

class SelectedCategoryNotifier extends StateNotifier<String> {
  String txt;
  SelectedCategoryNotifier(this.txt) : super(txt);

  void setText(String txt) {
    state = txt;
  }
}
