import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/paiement/class/qr_code_data.dart';

class BarcodeNotifier extends StateNotifier<QrCodeData?> {
  BarcodeNotifier() : super(null);

  void updateBarcode(String barcode) {
    state = QrCodeData.fromJson(jsonDecode(barcode));
  }

  void clearBarcode() {
    state = null;
  }
}

final barcodeProvider =
    StateNotifierProvider<BarcodeNotifier, QrCodeData?>((ref) {
  return BarcodeNotifier();
});
