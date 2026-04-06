import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/signed_content.dart';

class BarcodeNotifier extends StateNotifier<SignedContent?> {
  BarcodeNotifier() : super(null);

  SignedContent updateBarcode(String barcode) {
    state = SignedContent.fromJson(jsonDecode(barcode));
    return state!;
  }

  void clearBarcode() {
    state = null;
  }
}

final barcodeProvider = StateNotifierProvider<BarcodeNotifier, SignedContent?>((
  ref,
) {
  return BarcodeNotifier();
});
