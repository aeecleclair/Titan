import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myecl/paiement/class/qr_code_data.dart';
import 'package:myecl/paiement/class/qr_code_signature_data.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/tools/key_service.dart';

String getMonth(int m) {
  switch (m) {
    case 0:
      return "Décembre";
    case 1:
      return "Janvier";
    case 2:
      return "Février";
    case 3:
      return "Mars";
    case 4:
      return "Avril";
    case 5:
      return "Mai";
    case 6:
      return "Juin";
    case 7:
      return "Juillet";
    case 8:
      return "Août";
    case 9:
      return "Septembre";
    case 10:
      return "Octobre";
    case 11:
      return "Novembre";
    case 12:
      return "Décembre";
    default:
      return "";
  }
}

String castListInt(List<int> list) {
  return String.fromCharCodes(list);
}

List<int> castStringToListInt(String str) {
  return str.codeUnits;
}

Widget getStatusTag(WalletDeviceStatus status) {
  switch (status) {
    case WalletDeviceStatus.active:
      return Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: const Text(
          'Actif',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
    case WalletDeviceStatus.unactive:
      return Container(
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: const Text(
          'Inactif',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
    case WalletDeviceStatus.disabled:
      return Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: const Text(
          'Désactivé',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
  }
}

Future<String> getQRCodeContent(
  String id,
  String payAmount,
  KeyService keyService,
  bool store,
) async {
  final keyId = await keyService.getKeyId();
  final keyPair = await keyService.getKeyPair();
  final now = DateTime.now();
  final total = (double.parse(payAmount.replaceAll(',', '.')) * 100) ~/ 1;
  final data = QrCodeSignatureData(
    id: id,
    tot: total,
    iat: now,
    key: keyId!,
    store: store,
  ).toJson().toString();
  return QrCodeData(
    qrCodeId: id,
    total: total,
    creation: now,
    walletDeviceId: keyId,
    store: store,
    signature: base64Encode(
      (await keyService.signMessage(keyPair!, data.codeUnits)).bytes,
    ),
  ).toJson().toString();
}
