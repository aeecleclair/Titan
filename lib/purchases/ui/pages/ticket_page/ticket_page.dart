import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/providers/ticket_provider.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/purchases/ui/purchases.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends HookConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticket = ref.watch(ticketProvider);
    final ticketNotifier = ref.watch(ticketProvider.notifier);

    return PurchasesTemplate(
      child: Refresher(
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
                  data.productVariant.nameFR,
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  data.productVariant.nameEN,
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                const SizedBox(height: 10),
                QrImageView(
                  data: data.qrCodeSecret,
                  size: 200,
                ),
                const SizedBox(height: 10),
                Text(
                  "${PurchasesTextConstants.leftScan}: ${data.scanLeft.toString()}",
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
