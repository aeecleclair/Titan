import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/prize.dart';
import 'package:titan/raffle/class/raffle_status_type.dart';
import 'package:titan/raffle/class/tickets.dart';
import 'package:titan/raffle/providers/prize_list_provider.dart';
import 'package:titan/raffle/providers/prize_provider.dart';
import 'package:titan/raffle/providers/raffle_provider.dart';
import 'package:titan/raffle/providers/winning_ticket_list_provider.dart';
import 'package:titan/raffle/router.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/pages/creation_edit_page/prize_card.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PrizeHandler extends HookConsumerWidget {
  const PrizeHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final prizeNotifier = ref.watch(prizeProvider.notifier);
    final prizesNotifier = ref.watch(prizeListProvider.notifier);
    final prizeList = ref.watch(prizeListProvider);
    final winningTicketListNotifier = ref.watch(
      winningTicketListProvider.notifier,
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    void displayWinningsDialog(List<Ticket> winningTickets) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 100 + winningTickets.length * 35.0,
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    "Gagnant${winningTickets.length > 1 ? 's' : ''}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: RaffleColorConstants.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: winningTickets.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            winningTickets[index].user.getName(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: RaffleColorConstants.textDark,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Lots",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RaffleColorConstants.textDark,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              const SizedBox(width: 10),
              if (raffle.raffleStatusType == RaffleStatusType.creation)
                GestureDetector(
                  onTap: () {
                    prizeNotifier.setPrize(Prize.empty());
                    QR.to(
                      RaffleRouter.root +
                          RaffleRouter.detail +
                          RaffleRouter.creation +
                          RaffleRouter.addEditPrize,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 5.0, bottom: 10),
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: 100,
                      height: 125,
                      decoration: BoxDecoration(
                        gradient: const RadialGradient(
                          colors: [Color(0xff0193a5), Color(0xff004a59)],
                          center: Alignment.topLeft,
                          radius: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: RaffleColorConstants.textDark.withValues(
                              alpha: 0.2,
                            ),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: HeroIcon(
                          HeroIcons.plus,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              prizeList.when(
                data: (lots) {
                  lots = lots
                      .where((element) => element.raffleId == raffle.id)
                      .toList();
                  return lots.isEmpty
                      ? const SizedBox(
                          height: 150,
                          child: Center(child: Text("Aucun Lot")),
                        )
                      : Row(
                          children: lots
                              .map(
                                (e) => PrizeCard(
                                  lot: e,
                                  onDelete: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => CustomDialogBox(
                                        title: "Supprimer le lot",
                                        descriptions:
                                            "Voulez-vous vraiment supprimer ce lot?",
                                        onYes: () {
                                          tokenExpireWrapper(ref, () async {
                                            final value = await prizesNotifier
                                                .deletePrize(e);
                                            if (value) {
                                              displayToastWithContext(
                                                TypeMsg.msg,
                                                RaffleTextConstants.deletePrize,
                                              );
                                            } else {
                                              displayToastWithContext(
                                                TypeMsg.error,
                                                RaffleTextConstants
                                                    .deletingError,
                                              );
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  },
                                  onEdit: () {
                                    prizeNotifier.setPrize(e);
                                    QR.to(
                                      RaffleRouter.root +
                                          RaffleRouter.detail +
                                          RaffleRouter.creation +
                                          RaffleRouter.addEditPrize,
                                    );
                                  },
                                  status: raffle.raffleStatusType,
                                  onDraw: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => CustomDialogBox(
                                        title: "Tirage",
                                        descriptions:
                                            "Tirer le gagnant de ce lot ?",
                                        onYes: () {
                                          tokenExpireWrapper(ref, () async {
                                            final value =
                                                await winningTicketListNotifier
                                                    .drawPrize(e);
                                            value.when(
                                              data: (winningTicketList) {
                                                prizesNotifier
                                                    .setPrizeQuantityToZero(
                                                      e.copyWith(quantity: 0),
                                                    );
                                                displayWinningsDialog(
                                                  winningTicketList,
                                                );
                                              },
                                              error: (e, s) {
                                                displayToastWithContext(
                                                  TypeMsg.error,
                                                  RaffleTextConstants
                                                      .drawingError,
                                                );
                                              },
                                              loading: () {},
                                            );
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        );
                },
                error: (Object error, StackTrace stackTrace) {
                  return Center(child: Text("error : $error"));
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
