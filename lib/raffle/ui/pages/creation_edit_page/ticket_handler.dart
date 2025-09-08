import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/raffle/class/pack_ticket.dart';
import 'package:titan/raffle/class/raffle_status_type.dart';
import 'package:titan/raffle/providers/pack_ticket_list_provider.dart';
import 'package:titan/raffle/providers/pack_ticket_provider.dart';
import 'package:titan/raffle/providers/raffle_provider.dart';
import 'package:titan/raffle/router.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/pages/creation_edit_page/ticket_ui.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TicketHandler extends HookConsumerWidget {
  const TicketHandler({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final raffle = ref.watch(raffleProvider);
    final packTickets = ref.watch(packTicketListProvider);
    final packTicketsNotifier = ref.watch(packTicketListProvider.notifier);
    final packTicketNotifier = ref.watch(packTicketProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Tickets",
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
              const SizedBox(width: 15, height: 125),
              if (raffle.raffleStatusType == RaffleStatusType.creation)
                GestureDetector(
                  onTap: () {
                    packTicketNotifier.setPackTicket(PackTicket.empty());
                    QR.to(
                      RaffleRouter.root +
                          RaffleRouter.detail +
                          RaffleRouter.creation +
                          RaffleRouter.addEditPackTicket,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      bottom: 12,
                      top: 8,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    height: 125,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: RaffleColorConstants.ticketBack,
                      boxShadow: [
                        BoxShadow(
                          color: RaffleColorConstants.ticketBack.withValues(
                            alpha: 0.3,
                          ),
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
                  ),
                ),
              packTickets.when(
                data: (data) {
                  return Row(
                    children: data
                        .map(
                          (e) => TicketUI(
                            packTicket: e,
                            onEdit: () {
                              packTicketNotifier.setPackTicket(e);
                              QR.to(
                                RaffleRouter.root +
                                    RaffleRouter.detail +
                                    RaffleRouter.creation +
                                    RaffleRouter.addEditPackTicket,
                              );
                            },
                            showButton:
                                raffle.raffleStatusType ==
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
                                      final value = await packTicketsNotifier
                                          .deletePackTicket(e);
                                      if (value) {
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          RaffleTextConstants.deletedTicket,
                                        );
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          RaffleTextConstants.deletingError,
                                        );
                                      }
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
                error: (Object e, StackTrace? s) =>
                    Text("Error: ${e.toString()}"),
                loading: () => const CircularProgressIndicator(
                  color: RaffleColorConstants.gradient2,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}
