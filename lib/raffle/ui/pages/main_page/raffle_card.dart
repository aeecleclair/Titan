import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/class/stats.dart';
import 'package:myecl/raffle/providers/prize_list_provider.dart';
import 'package:myecl/raffle/providers/raffle_id_provider.dart';
import 'package:myecl/raffle/providers/raffle_stats_map_provider.dart';
import 'package:myecl/raffle/providers/raffle_stats_provider.dart';
import 'package:myecl/raffle/providers/ticket_list_provider.dart';
import 'package:myecl/raffle/providers/type_ticket_provider.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/raffle.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RaffleWidget extends HookConsumerWidget {
  final Raffle raffle;
  const RaffleWidget({super.key, required this.raffle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffleIdNotifier = ref.watch(raffleIdProvider.notifier);
    final prizeListNotifier = ref.read(prizeListProvider.notifier);
    final ticketListNotifier = ref.watch(ticketsListProvider.notifier);
    final typeTicketListNotifier = ref.watch(typeTicketsListProvider.notifier);
    final singleRaffleStats = ref.watch(raffleStatsProvider.notifier);
    final raffleStats = ref.watch(raffleStatsMapProvider);
    final rafflesStatsNotifier = ref.watch(raffleStatsMapProvider.notifier);
    return RaffleTemplate(
      child: GestureDetector(
          onTap: () {
            raffleIdNotifier.setId(raffle.id);
            prizeListNotifier.loadPrizeList();
            ticketListNotifier.loadTicketList();
            typeTicketListNotifier.loadTypeTicketSimpleList();
            QR.to(RaffleRouter.root + RaffleRouter.raffle);
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
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(2, 3),
                  ),
                ]),
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
                                  fontSize: 30),
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                raffleStats.when(
                  data: (statsList) {
                    final stats = statsList[raffle.id];
                    if (stats != null) {
                      return stats.when(
                        data: (stats) {
                          if (stats.isEmpty) {
                            Future.delayed(const Duration(milliseconds: 1), () {
                              rafflesStatsNotifier.setTData(
                                  raffle.id, const AsyncLoading());
                            });
                            tokenExpireWrapper(ref, () async {
                              final stats = await singleRaffleStats
                                  .loadRaffleStats(customRaffleId: raffle.id);
                              final statsList = stats.whenData<List<RaffleStats>>(
                                  (value) => [value]);
                              rafflesStatsNotifier.setTData(raffle.id, statsList);
                            });
                            return const SizedBox();
                          }
                          return Row(
                            children: [
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    stats[0].ticketsSold.toString(),
                                    style: const TextStyle(
                                        color: RaffleColorConstants.textDark,
                                        fontSize: 30),
                                  ),
                                  const Text(
                                    RaffleTextConstants.tickets,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: RaffleColorConstants.textDark,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${stats[0].amountRaised.toStringAsFixed(2)} €",
                                    style: const TextStyle(
                                        color: RaffleColorConstants.textDark,
                                        fontSize: 30),
                                  ),
                                  const Text(
                                    RaffleTextConstants.gathered,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: RaffleColorConstants.textDark,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          );
                        },
                        loading: () {
                          Future.delayed(const Duration(milliseconds: 1), () {
                            rafflesStatsNotifier.setTData(
                                raffle.id, const AsyncLoading());
                          });
                          tokenExpireWrapper(ref, () async {
                            final stats = await singleRaffleStats.loadRaffleStats(
                                customRaffleId: raffle.id);
                            final statsList = stats
                                .whenData<List<RaffleStats>>((value) => [value]);
                            rafflesStatsNotifier.setTData(raffle.id, statsList);
                          });
                          return const SizedBox();
                        },
                        error: (error, stack) => const SizedBox(),
                      );
                    } else {
                      Future.delayed(const Duration(milliseconds: 1), () {
                        rafflesStatsNotifier.setTData(
                            raffle.id, const AsyncLoading());
                      });
                      tokenExpireWrapper(ref, () async {
                        final stats = await singleRaffleStats.loadRaffleStats(
                            customRaffleId: raffle.id);
                        final statsList =
                            stats.whenData<List<RaffleStats>>((value) => [value]);
                        rafflesStatsNotifier.setTData(raffle.id, statsList);
                      });
                      return const SizedBox();
                    }
                  },
                  error: (Object error, StackTrace stackTrace) => const SizedBox(),
                  loading: () => const SizedBox(),
                ),
              ],
            ),
          ))),
    );
  }
}
