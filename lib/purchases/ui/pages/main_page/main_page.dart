import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/providers/purchases_admin_provider.dart';
import 'package:titan/purchases/providers/ticket_list_provider.dart';
import 'package:titan/purchases/providers/ticket_provider.dart';
import 'package:titan/purchases/router.dart';
import 'package:titan/purchases/tools/constants.dart';
import 'package:titan/purchases/ui/pages/main_page/custom_button.dart';
import 'package:titan/purchases/ui/pages/main_page/ticket_card.dart';
import 'package:titan/purchases/ui/purchases.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PurchasesMainPage extends HookConsumerWidget {
  const PurchasesMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isPurchasesAdminProvider);
    final ticketList = ref.watch(ticketListProvider);
    final ticketListNotifier = ref.watch(ticketListProvider.notifier);
    final ticketNotifier = ref.watch(ticketProvider.notifier);

    return PurchasesTemplate(
      child: Refresher(
        onRefresh: () async {
          await ticketListNotifier.loadTickets();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    icon: HeroIcons.clock,
                    text: PurchasesTextConstants.history,
                    onTap: () {
                      QR.to(PurchasesRouter.root + PurchasesRouter.history);
                    },
                  ),
                  if (isAdmin)
                    CustomButton(
                      icon: HeroIcons.viewfinderCircle,
                      text: PurchasesTextConstants.scan,
                      onTap: () {
                        QR.to(PurchasesRouter.root + PurchasesRouter.scan);
                      },
                    ),
                ],
              ),
            ),
            const AlignLeftText(
              padding: EdgeInsets.only(left: 30),
              PurchasesTextConstants.tickets,
              fontSize: 20,
            ),
            AsyncChild(
              value: ticketList,
              builder: (context, tickets) {
                return Column(
                  children: [
                    if (tickets.isEmpty)
                      const Center(
                        child: Text(PurchasesTextConstants.noTickets),
                      )
                    else
                      ...ticketList.maybeWhen(
                        data: (tickets) => tickets.map(
                          (ticket) => TicketCard(
                            ticket: ticket,
                            onClicked: () async {
                              await tokenExpireWrapper(ref, () async {
                                ticketNotifier.setTicket(ticket);
                                ticketNotifier.loadTicketSecret();
                                QR.to(
                                  PurchasesRouter.root + PurchasesRouter.ticket,
                                );
                              });
                            },
                          ),
                        ),
                        orElse: () => [
                          const Text(PurchasesTextConstants.ticketsError),
                        ],
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
