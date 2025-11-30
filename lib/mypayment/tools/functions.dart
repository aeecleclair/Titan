import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:titan/mypayment/class/history.dart';
import 'package:titan/mypayment/class/qr_code_data.dart';
import 'package:titan/mypayment/class/qr_code_signature_data.dart';
import 'package:titan/mypayment/class/wallet_device.dart';
import 'package:titan/mypayment/tools/key_service.dart';

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
            fontSize: 18,
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
            fontSize: 18,
          ),
        ),
      );
    case WalletDeviceStatus.revoked:
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
            fontSize: 18,
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
  final total = (double.parse(payAmount.replaceAll(',', '.')) * 100).round();
  final data = jsonEncode(
    QrCodeSignatureData(
      id: id,
      tot: total,
      iat: now,
      key: keyId!,
      store: store,
    ).toJson(),
  );
  return jsonEncode(
    QrCodeData(
      id: id,
      tot: total,
      iat: now,
      key: keyId,
      store: store,
      signature: base64Encode(
        (await keyService.signMessage(keyPair!, data.codeUnits)).bytes,
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

int statusOrder(WalletDeviceStatus status) {
  switch (status) {
    case WalletDeviceStatus.active:
      return 0;
    case WalletDeviceStatus.inactive:
      return 1;
    case WalletDeviceStatus.revoked:
      return 2;
  }
}

/// Generates a list of slightly randomized colors based on a seed string
/// The returned colors will maintain the same general appearance and order
/// as the input colors, with variations applied with intelligent damping effect
/// Alpha values are preserved exactly as in the original colors
List<Color> generateColorVariations(List<Color> baseColors, String seed) {
  // Generate a color displacement vector based on the seed string
  final colorVector = _generateColorVector(seed);

  // Determine if the vector creates a lighter or darker variation overall
  final bool isLightening = _isLighteningVector(colorVector);

  // Apply the vector with intelligent damping to the base colors
  List<Color> result = [];
  for (int i = 0; i < baseColors.length; i++) {
    // Calculate damping factor based on position and whether we're lightening or darkening
    double dampingFactor;

    if (isLightening) {
      // For lightening effects: first color gets most effect (0.8), gradually reduce effect
      dampingFactor = 0.8 / (i + 1);
    } else {
      // For darkening effects: first color gets most effect (1.2), gradually reduce effect
      dampingFactor = 1.2 / (i + 1);
    }

    // Apply damped vector to this color
    result.add(_applyColorVector(baseColors[i], colorVector, dampingFactor));
  }

  return result;
}

/// Determines if a color vector tends to lighten or darken colors
bool _isLighteningVector(List<int> vector) {
  // Simple heuristic: if sum of RGB adjustments is positive, it's lightening
  return (vector[0] * 0.299 + vector[1] * 0.587 + vector[2] * 0.114) / 255 >
      0.0;
}

/// Generates a color displacement vector based on a string seed
/// Returns a list [r, g, b] with values typically between -25 and 25
List<int> _generateColorVector(String seed) {
  final int seedValue = _generateSeedFromString(seed);
  final random = math.Random(seedValue);

  // Maximum displacement for any color component
  const int maxDisplacement = 25;

  return [
    (random.nextDouble() * maxDisplacement * 2 - maxDisplacement).round(),
    (random.nextDouble() * maxDisplacement * 2 - maxDisplacement).round(),
    (random.nextDouble() * maxDisplacement * 2 - maxDisplacement).round(),
  ];
}

/// Applies a color displacement vector to a color with damping
Color _applyColorVector(
  Color baseColor,
  List<int> vector,
  double dampingFactor,
) {
  // Get base color components
  final int r = (baseColor.r * 255.0).round() & 0xFF;
  final int g = (baseColor.g * 255.0).round() & 0xFF;
  final int b = (baseColor.b * 255.0).round() & 0xFF;

  // Apply the damped vector - using more sophisticated adjustment for more natural color shifts
  final int newR = (r + (vector[0] * dampingFactor).round()).clamp(0, 255);
  final int newG = (g + (vector[1] * dampingFactor).round()).clamp(0, 255);
  final int newB = (b + (vector[2] * dampingFactor).round()).clamp(0, 255);

  // Calculate color brightness adjustment to ensure colors maintain proper visual hierarchy
  double originalBrightness = (r * 0.299 + g * 0.587 + b * 0.114) / 255;
  double newBrightness = (newR * 0.299 + newG * 0.587 + newB * 0.114) / 255;

  // Adjust RGB values if brightness shift is too extreme
  int finalR = newR;
  int finalG = newG;
  int finalB = newB;

  // If brightness has changed too dramatically, moderate the change
  if ((newBrightness - originalBrightness).abs() > 0.2) {
    double correction = (originalBrightness - newBrightness) * 0.5;
    finalR = (newR + correction * 255).round().clamp(0, 255);
    finalG = (newG + correction * 255).round().clamp(0, 255);
    finalB = (newB + correction * 255).round().clamp(0, 255);
  }

  // Create new color with the same opacity as the original
  return Color.fromRGBO(finalR, finalG, finalB, baseColor.a);
}

/// Converts a string to an integer seed value
int _generateSeedFromString(String input) {
  // Simple hash function for the string
  int hash = 0;
  for (int i = 0; i < input.length; i++) {
    hash = input.codeUnitAt(i) + ((hash << 5) - hash);
  }
  return hash.abs();
}

List<Color> getTransactionColors(History transaction) {
  switch (transaction.type) {
    case HistoryType.given:
      return [
        const Color.fromARGB(255, 1, 127, 128),
        const Color.fromARGB(255, 0, 102, 103),
        const Color.fromARGB(255, 0, 44, 45).withValues(alpha: 0.3),
      ];
    case HistoryType.refundDebited:
      return [
        const Color.fromARGB(255, 4, 84, 84),
        const Color.fromARGB(255, 0, 68, 68),
        const Color.fromARGB(255, 0, 29, 29).withValues(alpha: 0.4),
      ];
    case HistoryType.refundCredited:
      return [
        const Color.fromARGB(255, 4, 84, 84),
        const Color.fromARGB(255, 0, 68, 68),
        const Color.fromARGB(255, 0, 29, 29).withValues(alpha: 0.4),
      ];
    case HistoryType.transfer:
      return [
        const Color.fromARGB(255, 255, 119, 7),
        const Color.fromARGB(255, 230, 103, 0),
        const Color.fromARGB(255, 97, 44, 0).withValues(alpha: 0.2),
      ];
    case HistoryType.received:
      return [
        const Color.fromARGB(255, 1, 127, 128),
        const Color.fromARGB(255, 0, 102, 103),
        const Color.fromARGB(255, 0, 44, 45).withValues(alpha: 0.3),
      ];
  }
}
