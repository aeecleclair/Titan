import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/class/raffle_status_type.dart';
import 'package:myecl/tombola/providers/cash_provider.dart';
import 'package:myecl/tombola/providers/lot_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/raffle_stats_provider.dart';
import 'package:myecl/tombola/providers/pack_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/blue_btn.dart';
import 'package:myecl/tombola/ui/pages/creation_edit_page/ticket_handler.dart';
import 'package:myecl/tombola/ui/pages/creation_edit_page/lot_handler.dart';
import 'package:myecl/tombola/ui/pages/creation_edit_page/winning_ticket_handler.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class CreationPage extends HookConsumerWidget {
  const CreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final raffleListNotifier = ref.read(raffleListProvider.notifier);
    final raffleStats = ref.watch(raffleStatsProvider);
    final cashNotifier = ref.read(cashProvider.notifier);
    final packTicketListNotifier = ref.read(packTicketListProvider.notifier);
    final lotListNotifier = ref.read(lotListProvider.notifier);

    return Refresher(
        onRefresh: () async {
          await cashNotifier.loadCashList();
          await packTicketListNotifier.loadPackTicketList();
          await lotListNotifier.loadLotList();
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const RadialGradient(
                        colors: [
                          Colors.black,
                          TombolaColorConstants.gradient2,
                        ],
                        radius: 6.0,
                        tileMode: TileMode.mirror,
                        center: Alignment.topLeft,
                      ).createShader(bounds),
                  child: Center(
                      child: Text(raffle.name,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )))),
            ),
            const SizedBox(
              height: 12,
            ),
            raffle.raffleStatusType != RaffleStatusType.locked
                ? const TicketHandler()
                : const WinningTicketHandler(),
            const SizedBox(
              height: 12,
            ),
            const LotHandler(),
            raffle.raffleStatusType != RaffleStatusType.locked
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    child: ShrinkButton(
                        waitChild:
                            const BlueBtn(text: TombolaTextConstants.waiting),
                        onTap: () async {
                          await tokenExpireWrapper(ref, () async {
                            await showDialog(
                                context: context,
                                builder: (context) => CustomDialogBox(
                                      title: raffle.raffleStatusType ==
                                              RaffleStatusType.creation
                                          ? TombolaTextConstants.openRaffle
                                          : TombolaTextConstants.closeRaffle,
                                      descriptions: raffle.raffleStatusType ==
                                              RaffleStatusType.creation
                                          ? TombolaTextConstants
                                              .openRaffleDescription
                                          : TombolaTextConstants
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
                                                      RaffleStatusType.locked),
                                            );
                                            break;
                                          default:
                                        }
                                      },
                                    ));
                          });
                        },
                        child: BlueBtn(
                            text:
                                raffle.raffleStatusType == RaffleStatusType.open
                                    ? TombolaTextConstants.close
                                    : TombolaTextConstants.open)),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        const Spacer(),
                        raffleStats.when(
                            data: (stats) => Column(
                                  children: [
                                    Text(
                                      stats.ticketsSold.toString(),
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
                        raffleStats.when(
                            data: (stats) => Column(
                                  children: [
                                    Text(
                                      "${stats.amountRaised.toStringAsFixed(2)} €",
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
                  ),
          ],
        ));
  }
}
