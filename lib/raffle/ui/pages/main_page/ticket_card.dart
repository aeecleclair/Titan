import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/class/tickets.dart';
import 'package:titan/raffle/providers/raffle_list_provider.dart';
import 'package:titan/raffle/providers/tombola_logo_provider.dart';
import 'package:titan/raffle/providers/tombola_logos_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/pages/main_page/ticket_card_background.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class TicketWidget extends HookConsumerWidget {
  final List<Ticket> ticket;
  final double price;
  const TicketWidget({super.key, required this.ticket, required this.price});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWinningTicket = ticket[0].prize != null;
    final raffleList = ref.watch(raffleListProvider);
    final raffle = raffleList.maybeWhen(
      data: (data) => data.firstWhere(
        (element) => element.id == ticket[0].packTicket.raffleId,
      ),
      orElse: () => Raffle.empty(),
    );
    final tombolaLogos = ref.watch(tombolaLogosProvider);
    final tombolaLogosNotifier = ref.watch(tombolaLogosProvider.notifier);
    final tombolaLogoNotifier = ref.watch(tombolaLogoProvider.notifier);
    return Stack(
      children: [
        TicketCardBackground(
          isWinningTicket: isWinningTicket,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: isWinningTicket ? 9 : 12,
              horizontal: isWinningTicket ? 14 : 17,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(2, 3),
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Builder(
                          builder: (context) {
                            if (tombolaLogos[raffle.id] != null) {
                              return tombolaLogos[raffle.id]!.when(
                                data: (tombolaLogos) {
                                  if (tombolaLogos.isNotEmpty) {
                                    return tombolaLogos.first;
                                  } else {
                                    Future.delayed(
                                      const Duration(milliseconds: 1),
                                      () {
                                        tombolaLogosNotifier.setTData(
                                          raffle.id,
                                          const AsyncLoading(),
                                        );
                                      },
                                    );
                                    tokenExpireWrapper(ref, () async {
                                      tombolaLogoNotifier
                                          .getLogo(raffle.id)
                                          .then((value) {
                                            tombolaLogosNotifier.setTData(
                                              raffle.id,
                                              AsyncData([value]),
                                            );
                                          });
                                    });
                                    return const HeroIcon(
                                      HeroIcons.cubeTransparent,
                                    );
                                  }
                                },
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (Object error, StackTrace? stackTrace) =>
                                    const HeroIcon(HeroIcons.cubeTransparent),
                              );
                            } else {
                              return const HeroIcon(HeroIcons.cubeTransparent);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        isWinningTicket
                            ? "${RaffleTextConstants.winner} !"
                            : "${price.toStringAsFixed(2)} €",
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: isWinningTicket ? Colors.black : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                AutoSizeText(
                  isWinningTicket
                      ? ticket[0].prize!.name
                      : "${ticket.length} ${RaffleTextConstants.ticket}${ticket.length > 1 ? "s" : ""}",
                  maxLines: 2,
                  style: TextStyle(
                    color: isWinningTicket
                        ? Colors.black.withValues(alpha: 0.8)
                        : Colors.white.withValues(alpha: 0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                AutoSizeText(
                  raffle.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isWinningTicket ? Colors.black : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
