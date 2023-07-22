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
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text("Tickets",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RaffleColorConstants.textDark)),
        ),
        const SizedBox(
          height: 10,
        ),
        HorizontalListView(
          child: Row(
            children: [
              const SizedBox(
                width: 15,
                height: 125,
              ),
              if (raffle.raffleStatusType == RaffleStatusType.creation)
                GestureDetector(
                    onTap: () {
                      typeTicketNotifier.setPrize(TypeTicketSimple.empty());
                      QR.to(RaffleRouter.root +
                          RaffleRouter.admin +
                          RaffleRouter.addEditTypeTicket);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 12, top: 8),
                      padding: const EdgeInsets.all(12.0),
                      height: 125,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: RaffleColorConstants.ticketBack,
                        boxShadow: [
                          BoxShadow(
                            color: RaffleColorConstants.ticketBack
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(2, 3),
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
                    )),
              typeTickets.when(
                data: (data) {
                  return Row(
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
                                            title: "Supprimer le ticket",
                                            descriptions:
                                                "Voulez-vous vraiment supprimer ce ticket?",
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
                          .toList());
                },
                error: (Object e, StackTrace? s) =>
                    Text("Error: ${e.toString()}"),
                loading: () => const CircularProgressIndicator(
                  color: RaffleColorConstants.gradient2,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}