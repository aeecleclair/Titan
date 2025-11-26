import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmailDialogNotifier extends StateNotifier<bool> {
  EmailDialogNotifier() : super(false);

  void close() {
    state = false;
  }

  void open() {
    state = true;
  }
}

final isEmailDialogOpenProvider =
    StateNotifierProvider<EmailDialogNotifier, bool>((ref) {
      return EmailDialogNotifier();
    });
