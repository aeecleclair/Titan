import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/raffle/class/raffle_status_type.dart';
import 'package:myecl/raffle/class/type_ticket_simple.dart';
import 'package:myecl/raffle/providers/raffle_provider.dart';
import 'package:myecl/raffle/providers/ticket_type_provider.dart';
import 'package:myecl/raffle/providers/type_ticket_provider.dart';
import 'package:myecl/raffle/router.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/pages/admin_page/ticket_ui.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TicketHandler extends HookConsumerWidget {
  const TicketHandler({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final typeTickets = ref.watch(typeTicketsListProvider);
    final typeTicketsNotifier = ref.watch(typeTicketsListProvider.notifier);
    final typeTicketNotifier = ref.watch(typeTicketProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Column(
      children: [
        const AlignLeftText(RaffleTextConstants.tickets,
            padding: EdgeInsets.symmetric(horizontal: 30),
            color: RaffleColorConstants.textDark),
        const SizedBox(height: 10),
        HorizontalListView(
          child: Row(
            children: [
              const SizedBox(width: 15, height: 125),
              if (raffle.raffleStatusType == RaffleStatusType.creation)
                GestureDetector(
                    onTap: () {
                      typeTicketNotifier.setPrize(TypeTicketSimple.empty());
                      QR.to(RaffleRouter.root +
                          RaffleRouter.admin +
                          RaffleRouter.addEditTypeTicket);
                    },
                    child: CardLayout(
                      height: 125,
                      width: 100,
                      colors: const [RaffleColorConstants.ticketBack],
                      shadowColor:
                          RaffleColorConstants.ticketBack.withOpacity(0.3),
                      child: const Center(
                        child: HeroIcon(
                          HeroIcons.plus,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    )),
              AsyncChild(
                  value: typeTickets,
                  builder: (context, data) => Row(
                      children: data
                          .map((e) => TicketUI(
                                typeTicket: e,
                                onEdit: () {
                                  typeTicketNotifier.setPrize(e);
                                  QR.to(RaffleRouter.root +
                                      RaffleRouter.admin +
                                      RaffleRouter.addEditTypeTicket);
                                },
                                showButton: raffle.raffleStatusType ==
                                    RaffleStatusType.creation,
                                onDelete: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) => CustomDialogBox(
                                            title: RaffleTextConstants
                                                .deleteTicket,
                                            descriptions: RaffleTextConstants
                                                .deleteTicketDescription,
                                            onYes: () {
                                              tokenExpireWrapper(ref, () async {
                                                final value =
                                                    await typeTicketsNotifier
                                                        .deleteTypeTicketSimple(
                                                            e);
                                                if (value) {
                                                  displayToastWithContext(
                                                      TypeMsg.msg,
                                                      RaffleTextConstants
                                                          .deletedTicket);
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
                              ))
                          .toList()),
                  loaderColor: RaffleColorConstants.gradient2),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}