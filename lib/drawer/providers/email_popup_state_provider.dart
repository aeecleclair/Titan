import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPopupStateProvider extends StateNotifier<bool> {
  EmailPopupStateProvider() : super(false);

  void open() {
    state = true;
  }

  void close() {
    state = false;
  }
}

final emailPopupStateProvider =
    StateNotifierProvider<EmailPopupStateProvider, bool>((ref) {
      return EmailPopupStateProvider();
    });
