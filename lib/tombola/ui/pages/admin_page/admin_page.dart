import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/providers/cash_provider.dart';
import 'package:myecl/tombola/providers/lot_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/ui/pages/admin_page/account_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_page/lot_handler.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final cashNotifier = ref.read(cashProvider.notifier);
    final typeTicketsListNotifier =
        ref.read(typeTicketsListProvider.notifier);
    final lotListNotifier = ref.read(lotListProvider.notifier);
    return Refresher(
        onRefresh: () async {
          await cashNotifier.loadCashList();
          await typeTicketsListNotifier.loadTypeTicketList(raffle.id);
          await lotListNotifier.loadLotList(raffle.id);
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
            LotHandler(),
          ],
        ));
  }
}
