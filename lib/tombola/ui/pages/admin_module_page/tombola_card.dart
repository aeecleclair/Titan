import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/stats.dart';
import 'package:myecl/tombola/providers/prize_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_id_provider.dart';
import 'package:myecl/tombola/providers/raffle_stats_map_provider.dart';
import 'package:myecl/tombola/providers/raffle_stats_provider.dart';
import 'package:myecl/tombola/providers/ticket_list_provider.dart';
import 'package:myecl/tombola/providers/tombola_logo_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/providers/pack_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TombolaCard extends HookConsumerWidget {
  final Raffle raffle;
  const TombolaCard({Key? key, required this.raffle}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final raffleIdNotifier = ref.watch(raffleIdProvider.notifier);
    final lotListNotifier = ref.read(prizeListProvider.notifier);
    final ticketListNotifier = ref.watch(ticketsListProvider.notifier);
    final packTicketListNotifier = ref.watch(packTicketListProvider.notifier);
    final singleRaffleStats = ref.watch(raffleStatsProvider.notifier);
    final raffleStats = ref.watch(raffleStatsMapProvider);
    final rafflesStatsNotifier = ref.watch(raffleStatsMapProvider.notifier);
    final tombolaLogo = ref.watch(tombolaLogoProvider);

    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                colors: [
                  TombolaColorConstants.gradient1,
                  TombolaColorConstants.gradient2,
                ],
                center: Alignment.topLeft,
                radius: 1.5,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: TombolaColorConstants.textDark.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    AutoSizeText(raffle.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 5),
                    AutoSizeText(raffle.group.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: TombolaColorConstants.textDark)),
                    const SizedBox(height: 5),
                    AutoSizeText(
                        raffleStatusTypeToString(raffle.raffleStatusType),
                        maxLines: 1,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 10),
                  ],
                ))));
  }
}
