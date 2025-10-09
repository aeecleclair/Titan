import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhSendPdfNotifier extends StateNotifier<Uint8List> {
  PhSendPdfNotifier() : super(Uint8List(0));

  void set(Uint8List i) {
    state = i;
  }
}

final phSendPdfProvider = StateNotifierProvider<PhSendPdfNotifier, Uint8List>((
  ref,
) {
  return PhSendPdfNotifier();
});
