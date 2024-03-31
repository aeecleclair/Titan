import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhTestNotifier extends StateNotifier<Uint8List> {
  PhTestNotifier() : super(Uint8List(0));

  void set(Uint8List i) {
    state = i;
  }
}

final phTestProvider = StateNotifierProvider<PhTestNotifier, Uint8List>((ref) {
  return PhTestNotifier();
});
