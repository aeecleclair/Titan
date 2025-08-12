import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/purchases/providers/purchases_admin_provider.dart';
import 'package:titan/purchases/providers/ticket_list_provider.dart';
import 'package:titan/purchases/providers/ticket_provider.dart';
import 'package:titan/purchases/router.dart';
import 'package:titan/purchases/ui/pages/main_page/custom_button.dart';
import 'package:titan/purchases/ui/pages/main_page/ticket_card.dart';
import 'package:titan/purchases/ui/purchases.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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
        controller: ScrollController(),
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
                    text: AppLocalizations.of(context)!.purchasesHistory,
                    onTap: () {
                      QR.to(PurchasesRouter.root + PurchasesRouter.history);
                    },
                  ),
                  if (isAdmin)
                    CustomButton(
                      icon: HeroIcons.viewfinderCircle,
                      text: AppLocalizations.of(context)!.purchasesScan,
                      onTap: () {
                        QR.to(PurchasesRouter.root + PurchasesRouter.scan);
                      },
                    ),
                ],
              ),
            ),
            AlignLeftText(
              padding: const EdgeInsets.only(left: 30),
              AppLocalizations.of(context)!.purchasesTickets,
              fontSize: 20,
            ),
            AsyncChild(
              value: ticketList,
              builder: (context, tickets) {
                return Column(
                  children: [
                    if (tickets.isEmpty)
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.purchasesNoTickets,
                        ),
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
                          Text(
                            AppLocalizations.of(context)!.purchasesTicketsError,
                          ),
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
