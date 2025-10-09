import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/providers/key_service_provider.dart';
import 'package:titan/paiement/providers/pay_amount_provider.dart';
import 'package:titan/paiement/tools/functions.dart';
import 'package:titan/tools/ui/widgets/loader.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class QrCode extends ConsumerWidget {
  const QrCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payAmount = ref.watch(payAmountProvider);
    final id = const Uuid().v4();
    final keyService = ref.watch(keyServiceProvider);
    return FutureBuilder(
      future: getQRCodeContent(id, payAmount, keyService, true),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            child: const Loader(),
          );
        }
        return Center(
          child: QrImageView(
            data: snapshot.data!,
            version: QrVersions.auto,
            size: min(
              MediaQuery.of(context).size.width * 0.8,
              MediaQuery.of(context).size.height * 0.8,
            ),
            eyeStyle: const QrEyeStyle(
              color: Colors.black,
              eyeShape: QrEyeShape.square,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
