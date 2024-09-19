import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPdfNotifier extends StateNotifier<bool> {
  EditPdfNotifier() : super(false);

  void editPdf(bool a) {
    state = a;
  }
}

final editPdfProvider = StateNotifierProvider<EditPdfNotifier, bool>((ref) {
  return EditPdfNotifier();
});
