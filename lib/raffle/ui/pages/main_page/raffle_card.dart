import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/class/stats.dart';
import 'package:titan/raffle/providers/pack_ticket_list_provider.dart';
import 'package:titan/raffle/providers/prize_list_provider.dart';
import 'package:titan/raffle/providers/raffle_id_provider.dart';
import 'package:titan/raffle/providers/raffle_stats_map_provider.dart';
import 'package:titan/raffle/providers/raffle_stats_provider.dart';
import 'package:titan/raffle/providers/ticket_list_provider.dart';
import 'package:titan/raffle/router.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/raffle.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RaffleWidget extends HookConsumerWidget {
  final Raffle raffle;
  const RaffleWidget({super.key, required this.raffle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffleIdNotifier = ref.watch(raffleIdProvider.notifier);
    final prizeListNotifier = ref.read(prizeListProvider.notifier);
    final ticketListNotifier = ref.watch(ticketsListProvider.notifier);
    final packTicketListNotifier = ref.watch(packTicketListProvider.notifier);
    final singleRaffleStats = ref.watch(raffleStatsProvider.notifier);
    final raffleStat = ref.watch(
      raffleStatsMapProvider.select((value) => value[raffle.id]),
    );
    final rafflesStatsNotifier = ref.watch(raffleStatsMapProvider.notifier);
    return RaffleTemplate(
      child: GestureDetector(
        onTap: () {
          raffleIdNotifier.setId(raffle.id);
          prizeListNotifier.loadPrizeList();
          ticketListNotifier.loadTicketList();
          packTicketListNotifier.loadPackTicketList();
          QR.to(RaffleRouter.root + RaffleRouter.detail);
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/soli.png"),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: AutoSizeText(
                            raffle.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: RaffleColorConstants.textDark,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AutoLoaderChild(
                  group: raffleStat,
                  notifier: rafflesStatsNotifier,
                  mapKey: raffle.id,
                  loader: (raffleId) async =>
                      (await singleRaffleStats.loadRaffleStats(
                        customRaffleId: raffleId,
                      )).maybeWhen(
                        data: (value) => value,
                        orElse: () => RaffleStats.empty(),
                      ),
                  dataBuilder: (context, stats) {
                    final stat = stats.first;
                    return Row(
                      children: [
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              stat.ticketsSold.toString(),
                              style: const TextStyle(
                                color: RaffleColorConstants.textDark,
                                fontSize: 30,
                              ),
                            ),
                            const Text(
                              RaffleTextConstants.tickets,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: RaffleColorConstants.textDark,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(flex: 2),
                        Column(
                          children: [
                            Text(
                              "${stat.amountRaised.toStringAsFixed(2)} €",
                              style: const TextStyle(
                                color: RaffleColorConstants.textDark,
                                fontSize: 30,
                              ),
                            ),
                            const Text(
                              RaffleTextConstants.gathered,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: RaffleColorConstants.textDark,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
