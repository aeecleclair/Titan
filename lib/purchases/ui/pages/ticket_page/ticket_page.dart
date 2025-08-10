import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/providers/ticket_provider.dart';
import 'package:titan/purchases/ui/purchases.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/loader.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:titan/l10n/app_localizations.dart';

class TicketPage extends HookConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticket = ref.watch(ticketProvider);
    final ticketNotifier = ref.watch(ticketProvider.notifier);

    return PurchasesTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await ticketNotifier.loadTicketSecret();
        },
        child: AsyncChild(
          value: ticket,
          builder: (context, data) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  data.name,
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  data.productVariant.nameFR,
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                const SizedBox(height: 10),
                data.qrCodeSecret != ""
                    ? QrImageView(
                        data: data.qrCodeSecret,
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
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: const Loader(),
                      ),
                const SizedBox(height: 10),
                Text(
                  "${AppLocalizations.of(context)!.purchasesLeftScan}: ${data.scanLeft.toString()}",
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  data.productVariant.descriptionFR,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  data.productVariant.descriptionEN,
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
