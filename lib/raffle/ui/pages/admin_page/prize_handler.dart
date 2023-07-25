import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/class/prize.dart';
import 'package:myecl/raffle/class/raffle_status_type.dart';
import 'package:myecl/raffle/class/tickets.dart';
import 'package:myecl/raffle/providers/prize_list_provider.dart';
import 'package:myecl/raffle/providers/prize_provider.dart';
import 'package:myecl/raffle/providers/raffle_provider.dart';
import 'package:myecl/raffle/providers/winning_ticket_list_provider.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/pages/admin_page/prize_card.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PrizeHandler extends HookConsumerWidget {
  const PrizeHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final prizeNotifier = ref.watch(prizeProvider.notifier);
    final prizeListNotifier = ref.watch(prizeListProvider.notifier);
    final prizeList = ref.watch(prizeListProvider);
    final winningTicketListNotifier =
        ref.watch(winningTicketListProvider.notifier);

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
                      "${RaffleTextConstants.winner}${winningTickets.length > 1 ? 's' : ''}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: RaffleColorConstants.textDark),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                                    color: RaffleColorConstants.textDark),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          });
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(RaffleTextConstants.prizes,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RaffleColorConstants.textDark)),
        ),
        const SizedBox(
          height: 10,
        ),
        HorizontalListView(
          child: Row(children: [
            const SizedBox(
              width: 10,
            ),
            if (raffle.raffleStatusType == RaffleStatusType.creation)
              GestureDetector(
                onTap: () {
                  prizeNotifier.setPrize(Prize.empty());
                  QR.to(RaffleRouter.root +
                      RaffleRouter.admin +
                      RaffleRouter.addEditPrize);
                },
                child: CardLayout(
                    width: 100,
                    height: 125,
                    colors: const [Color(0xff0193a5), Color(0xff004a59)],
                    shadowColor: RaffleColorConstants.textDark.withOpacity(0.2),
                    child: const Center(
                      child: HeroIcon(
                        HeroIcons.plus,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
              ),
            prizeList.when(
                data: (prizes) {
                  prizes = prizes
                      .where((element) => element.raffleId == raffle.id)
                      .toList();
                  return prizes.isEmpty
                      ? const SizedBox(
                          height: 150,
                          child: Center(
                            child: Text(RaffleTextConstants.noPrize),
                          ),
                        )
                      : Row(
                          children: prizes
                              .map(
                                (e) => PrizeCard(
                                  prize: e,
                                  onDelete: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => CustomDialogBox(
                                              title: RaffleTextConstants
                                                  .deletePrize,
                                              descriptions: RaffleTextConstants
                                                  .deletePrizeDescription,
                                              onYes: () {
                                                tokenExpireWrapper(ref,
                                                    () async {
                                                  final value =
                                                      await prizeListNotifier
                                                          .deletePrize(e);
                                                  if (value) {
                                                    displayToastWithContext(
                                                        TypeMsg.msg,
                                                        RaffleTextConstants
                                                            .deletedPrize);
                                                  } else {
                                                    displayToastWithContext(
                                                        TypeMsg.error,
                                                        RaffleTextConstants
                                                            .deletingError);
                                                  }
                                                });
                                              },
                                            ));
                                  },
                                  onEdit: () {
                                    prizeNotifier.setPrize(e);
                                    QR.to(RaffleRouter.root +
                                        RaffleRouter.admin +
                                        RaffleRouter.addEditPrize);
                                  },
                                  status: raffle.raffleStatusType,
                                  onDraw: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) => CustomDialogBox(
                                              title:
                                                  RaffleTextConstants.drawing,
                                              descriptions: RaffleTextConstants
                                                  .drawingDescription,
                                              onYes: () {
                                                tokenExpireWrapper(ref,
                                                    () async {
                                                  final value =
                                                      await winningTicketListNotifier
                                                          .drawPrize(e);
                                                  value.when(
                                                      data:
                                                          (winningTicketList) {
                                                        prizeListNotifier
                                                            .setPrizeQuantityToZero(
                                                                e.copyWith(
                                                                    quantity:
                                                                        0));
                                                        displayWinningsDialog(
                                                            winningTicketList);
                                                      },
                                                      error: (e, s) {
                                                        displayToastWithContext(
                                                            TypeMsg.error,
                                                            RaffleTextConstants
                                                                .drawingError);
                                                      },
                                                      loading: () {});
                                                });
                                              },
                                            ));
                                  },
                                ),
                              )
                              .toList(),
                        );
                },
                error: (Object error, StackTrace stackTrace) => Center(
                    child: Text("${RaffleTextConstants.error} : $error")),
                loading: () => const Loader()),
            const SizedBox(
              width: 10,
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
