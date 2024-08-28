import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/purchases/providers/scanner_provider.dart';
import 'package:myecl/purchases/providers/tag_provider.dart';
import 'package:myecl/purchases/providers/ticket_list_provider.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/purchases/ui/purchases.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ConfirmationPage extends HookConsumerWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanner = ref.watch(scannerProvider);
    final scannerNotifier = ref.watch(scannerProvider.notifier);
    final ticketsNotifier = ref.watch(ticketListProvider.notifier);
    final tag = ref.watch(tagProvider);

    return PurchasesTemplate(
      child: Refresher(
        onRefresh: () async {},
        child: AsyncChild(
          value: scanner,
          builder: (context, ticket) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  ticket.ticket.productVariant.nameFR,
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  ticket.user.getName(),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  ticket.user.floor,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  ticket.user.promo.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    await ticketsNotifier.consumeTicket(ticket, tag);
                    scannerNotifier.reset();
                    QR.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      PurchasesTextConstants.validate,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    scannerNotifier.reset();
                    QR.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      PurchasesTextConstants.cancel,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
