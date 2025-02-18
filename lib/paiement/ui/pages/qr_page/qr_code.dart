import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/key_service_provider.dart';
import 'package:myecl/paiement/providers/pay_amount_provider.dart';
import 'package:myecl/paiement/tools/functions.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class QrCode extends ConsumerWidget {
  const QrCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payAmount = ref.watch(payAmountProvider);
    final id = const Uuid().v4();
    final keyService = ref.watch(keyServiceProvider);
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: FutureBuilder(
          future: getQRCodeContent(id, payAmount, keyService),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
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
        ),
      ),
    );
  }
}
