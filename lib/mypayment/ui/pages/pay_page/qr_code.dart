import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/providers/key_service_provider.dart';
import 'package:titan/mypayment/providers/pay_amount_provider.dart';
import 'package:titan/mypayment/tools/functions.dart';
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
        switch (snapshot) {
          case AsyncSnapshot(:final error?):
            if (kDebugMode) {
              debugPrint('Could not load QR code: $error');
            }
            return Center(child: Text('Erreur lors du chargement du QR code'));
          case AsyncSnapshot(:final data?):
            return Center(
              child: QrImageView(
                data: data,
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
          case AsyncSnapshot():
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.8,
              child: const Loader(),
            );
        }
      },
    );
  }
}
