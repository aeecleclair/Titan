import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myecl/paiement/class/qr_code_data.dart';
import 'package:myecl/paiement/class/qr_code_signature_data.dart';
import 'package:myecl/paiement/class/wallet_device.dart';
import 'package:myecl/paiement/tools/key_service.dart';

enum TransferType { helloAsso, check, cash, bankTransfer }

String getMonth(int m) {
  final months = [
    "Décembre",
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
  ];
  return months[m];
}

Widget getStatusTag(WalletDeviceStatus status) {
  switch (status) {
    case WalletDeviceStatus.active:
      return Container(
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.2),
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
    case WalletDeviceStatus.inactive:
      return Container(
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.2),
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
          color: Colors.red.withValues(alpha: 0.2),
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
  ).toJson();
  return jsonEncode(
    QrCodeData(
      qrCodeId: id,
      total: total,
      creation: now,
      walletDeviceId: keyId,
      store: store,
      signature: base64Encode(
        (await keyService.signMessage(keyPair!, jsonEncode(data).codeUnits))
            .bytes,
      ),
    ).toJson(),
  );
}

String transferTypeToString(TransferType type) {
  switch (type) {
    case TransferType.bankTransfer:
      return "bank_transfer";
    case TransferType.helloAsso:
      return "hello_asso";
    case TransferType.cash:
      return "cash";
    case TransferType.check:
      return "check";
  }
}

TransferType transferTypeFromString(String type) {
  switch (type) {
    case "bank_transfer":
      return TransferType.bankTransfer;
    case "hello_asso":
      return TransferType.helloAsso;
    case "cash":
      return TransferType.cash;
    case "check":
      return TransferType.check;
    default:
      return TransferType.helloAsso;
  }
}
