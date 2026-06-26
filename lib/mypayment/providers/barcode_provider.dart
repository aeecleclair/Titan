import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class BarcodeNotifier extends Notifier<ScanInfo?> {
  @override
  ScanInfo? build() {
    return null;
  }

  ScanInfo updateBarcode(String barcode) {
    state = ScanInfo.fromJson(jsonDecode(barcode));
    return state!;
  }

  void clearBarcode() {
    state = null;
  }
}

final barcodeProvider = NotifierProvider<BarcodeNotifier, ScanInfo?>(
  BarcodeNotifier.new,
);
