import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/providers/cash_provider.dart';
import 'package:myecl/tombola/providers/lot_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/ticket_list_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/blue_btn.dart';
import 'package:myecl/tombola/ui/pages/admin_page/account_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_page/ticket_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_page/lot_handler.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final ticketList = ref.watch(ticketsListProvider);
    final cashNotifier = ref.read(cashProvider.notifier);
    final typeTicketsListNotifier = ref.read(typeTicketsListProvider.notifier);
    final lotListNotifier = ref.read(lotListProvider.notifier);

    return Refresher(
        onRefresh: () async {
          await cashNotifier.loadCashList();
          await typeTicketsListNotifier.loadTypeTicketList();
          await lotListNotifier.loadLotList();
        },
        child: Column(
          children: [
            const AccountHandler(),
            const SizedBox(
              height: 12,
            ),
            const TicketHandler(),
            const SizedBox(
              height: 12,
            ),
            const LotHandler(),
            const SizedBox(
              height: 12,
            ),
            raffle.raffleStatusType != RaffleStatusType.locked
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ShrinkButton(
                        waitChild:
                            const BlueBtn(text: TombolaTextConstants.waiting),
                        onTap: () async {
                          await tokenExpireWrapper(ref, () async {});
                        },
                        child: BlueBtn(
                            text:
                                raffle.raffleStatusType == RaffleStatusType.open
                                    ? TombolaTextConstants.close
                                    : TombolaTextConstants.open)),
                  )
                : Row(
                    children: [
                      const Spacer(),
                      ticketList.when(
                          data: (tickets) => Column(
                                children: [
                                  Text(
                                    tickets
                                        .fold<int>(
                                            0,
                                            (previousValue, element) =>
                                                previousValue +
                                                element.nbTicket)
                                        .toString(),
                                    style: const TextStyle(
                                        color: TombolaColorConstants.textDark,
                                        fontSize: 30),
                                  ),
                                  const Text(
                                    "Tickets",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: TombolaColorConstants.textDark,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                          error: (e, s) => const Text("Error"),
                          loading: () => const Center(
                                child: CircularProgressIndicator(
                                  color: TombolaColorConstants.textDark,
                                ),
                              )),
                      const Spacer(),
                      ticketList.when(
                          data: (tickets) => Column(
                                children: [
                                  Text(
                                    "${tickets.fold<int>(0, (previousValue, element) => previousValue + element.nbTicket * element.unitPrice)}€",
                                    style: const TextStyle(
                                        color: TombolaColorConstants.textDark,
                                        fontSize: 30),
                                  ),
                                  const Text(
                                    "Récoltés",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: TombolaColorConstants.textDark,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                          error: (e, s) => const Text("Error"),
                          loading: () => const Center(
                                child: CircularProgressIndicator(
                                  color: TombolaColorConstants.textDark,
                                ),
                              )),
                      const Spacer(),
                    ],
                  ),
            const SizedBox(
              height: 50,
            ),
          ],
        ));
  }
}
