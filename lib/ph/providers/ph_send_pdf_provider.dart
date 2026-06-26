import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhSendPdfNotifier extends Notifier<Uint8List> {
  @override
  Uint8List build() {
    return Uint8List(0);
  }

  void set(Uint8List i) {
    state = i;
  }
}

final phSendPdfProvider = NotifierProvider<PhSendPdfNotifier, Uint8List>(
  PhSendPdfNotifier.new,
);
