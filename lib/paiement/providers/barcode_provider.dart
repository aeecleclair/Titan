import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/qr_code_data.dart';

class BarcodeNotifier extends StateNotifier<QrCodeData?> {
  BarcodeNotifier() : super(null);

  QrCodeData updateBarcode(String barcode) {
    state = QrCodeData.fromJson(jsonDecode(barcode));
    return state!;
  }

  void clearBarcode() {
    state = null;
  }
}

final barcodeProvider = StateNotifierProvider<BarcodeNotifier, QrCodeData?>((
  ref,
) {
  return BarcodeNotifier();
});
