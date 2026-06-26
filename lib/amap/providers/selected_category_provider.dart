import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider =
    NotifierProvider.family<SelectedCategoryNotifier, String, String>(
      SelectedCategoryNotifier.new,
    );

class SelectedCategoryNotifier extends Notifier<String> {
  SelectedCategoryNotifier(this.initialText);

  final String initialText;

  @override
  String build() {
    return initialText;
  }

  void setText(String txt) {
    state = txt;
  }
}
