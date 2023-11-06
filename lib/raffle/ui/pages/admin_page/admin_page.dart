import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/raffle/class/raffle_status_type.dart';
import 'package:myecl/raffle/providers/cash_provider.dart';
import 'package:myecl/raffle/providers/pack_ticket_list_provider.dart';
import 'package:myecl/raffle/providers/prize_list_provider.dart';
import 'package:myecl/raffle/providers/raffle_list_provider.dart';
import 'package:myecl/raffle/providers/raffle_provider.dart';
import 'package:myecl/raffle/providers/raffle_stats_provider.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/pages/admin_page/blue_btn.dart';
import 'package:myecl/raffle/ui/pages/admin_page/account_handler.dart';
import 'package:myecl/raffle/ui/pages/admin_page/ticket_handler.dart';
import 'package:myecl/raffle/ui/pages/admin_page/prize_handler.dart';
import 'package:myecl/raffle/ui/pages/admin_page/winning_ticket_handler.dart';
import 'package:myecl/raffle/ui/raffle.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final raffleListNotifier = ref.read(raffleListProvider.notifier);
    final raffleStats = ref.watch(raffleStatsProvider);
    final cashNotifier = ref.read(cashProvider.notifier);
    final packTicketListNotifier = ref.read(packTicketListProvider.notifier);
    final prizeListNotifier = ref.read(prizeListProvider.notifier);

    return RaffleTemplate(
      child: Refresher(
          onRefresh: () async {
            await cashNotifier.loadCashList();
            await packTicketListNotifier.loadPackTicketList();
            await prizeListNotifier.loadPrizeList();
          },
          child: Column(
            children: [
              const AccountHandler(),
              const SizedBox(height: 12),
              raffle.raffleStatusType != RaffleStatusType.lock
                  ? const TicketHandler()
                  : const WinningTicketHandler(),
              const SizedBox(height: 12),
              const PrizeHandler(),
              raffle.raffleStatusType != RaffleStatusType.lock
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      child: WaitingButton(
                        waitingColor: RaffleColorConstants.gradient2,
                        builder: (child) => BlueBtn(child: child),
                        onTap: () async {
                          await tokenExpireWrapper(ref, () async {
                            await showDialog(
                                context: context,
                                builder: (context) => CustomDialogBox(
                                      title: raffle.raffleStatusType ==
                                              RaffleStatusType.creation
                                          ? RaffleTextConstants.openRaffle
                                          : RaffleTextConstants.closeRaffle,
                                      descriptions: raffle.raffleStatusType ==
                                              RaffleStatusType.creation
                                          ? RaffleTextConstants
                                              .openRaffleDescription
                                          : RaffleTextConstants
                                              .closeRaffleDescription,
                                      onYes: () async {
                                        switch (raffle.raffleStatusType) {
                                          case RaffleStatusType.creation:
                                            await raffleListNotifier.openRaffle(
                                                raffle.copyWith(
                                                    description:
                                                        raffle.description,
                                                    raffleStatusType:
                                                        RaffleStatusType.open));
                                            break;
                                          case RaffleStatusType.open:
                                            await raffleListNotifier.lockRaffle(
                                              raffle.copyWith(
                                                  description:
                                                      raffle.description,
                                                  raffleStatusType:
                                                      RaffleStatusType.lock),
                                            );
                                            break;
                                          default:
                                        }
                                      },
                                    ));
                          });
                        },
                        child: Text(
                          raffle.raffleStatusType == RaffleStatusType.open
                              ? RaffleTextConstants.close
                              : RaffleTextConstants.open,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: RaffleColorConstants.gradient2),
                        ),
                      ))
                  : Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: [
                          const Spacer(),
                          AsyncChild(
                              value: raffleStats,
                              builder: (context, stats) => Column(
                                    children: [
                                      Text(
                                        stats.ticketsSold.toString(),
                                        style: const TextStyle(
                                            color:
                                                RaffleColorConstants.textDark,
                                            fontSize: 30),
                                      ),
                                      const Text(
                                        RaffleTextConstants.tickets,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                RaffleColorConstants.textDark,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                              loaderColor: RaffleColorConstants.textDark),
                          const Spacer(),
                          AsyncChild(
                              value: raffleStats,
                              builder: (context, stats) => Column(
                                    children: [
                                      Text(
                                        "${stats.amountRaised.toStringAsFixed(2)} €",
                                        style: const TextStyle(
                                            color:
                                                RaffleColorConstants.textDark,
                                            fontSize: 30),
                                      ),
                                      const Text(
                                        RaffleTextConstants.gathered,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                RaffleColorConstants.textDark,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                              loaderColor: RaffleColorConstants.textDark),
                          const Spacer(),
                        ],
                      ),
                    ),
            ],
          )),
    );
  }
}
