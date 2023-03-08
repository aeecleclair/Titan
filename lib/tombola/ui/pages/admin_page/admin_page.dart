import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/providers/cash_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/ticket_list_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/ui/pages/admin_page/account_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_page/delivery_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_page/product_handler.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final cashNotifier = ref.read(cashProvider.notifier);
    final typeTicketsListProviderNotifier = ref.read(typeTicketsListProvider.notifier);
    return Refresher(
        onRefresh: () async {
          await cashNotifier.loadCashList();
          await typeTicketsListProviderNotifier.loadTypeTicketList(raffle.id);
          // TODO: lots
        },
        child: Column(
          children: const [
            AccountHandler(),
            SizedBox(
              height: 12,
            ),
            // DeliveryHandler(),
            SizedBox(
              height: 12,
            ),
            // ProductHandler(),
          ],
        ));
  }
}
