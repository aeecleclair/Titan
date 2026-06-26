import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditPdfNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void editPdf(bool a) {
    state = a;
  }
}

final editPdfProvider = NotifierProvider<EditPdfNotifier, bool>(
  EditPdfNotifier.new,
);
