import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/advert/ui/components/special_action_button.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/providers/can_manage_ticket_events_provider.dart';
import 'package:titan/tickets/class/user_ticket.dart';
import 'package:titan/tickets/providers/user_tickets_provider.dart';
import 'package:titan/tickets/router.dart';
import 'package:titan/tickets/ui/components/user_ticket_card.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

class TicketsMainPage extends HookConsumerWidget {
  const TicketsMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final userTicketsAsync = ref.watch(userTicketsProvider);
    final userTicketsNotifier = ref.watch(userTicketsProvider.notifier);
    final canManageTicketEvents = ref.watch(canManageTicketEventsProvider);
    final scrollController = useScrollController();

    // Rafraîchir la liste des tickets à l'arrivée sur la page
    useEffect(() {
      userTicketsNotifier.loadUserTickets();
      return null;
    }, []);

    return TicketTemplate(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                Text(
                  l10n.ticketsTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
                const Spacer(),
                if (canManageTicketEvents) ...[
                  const SizedBox(width: 10),
                  SpecialActionButton(
                    icon: HeroIcon(HeroIcons.userGroup, color: Colors.white),
                    name: l10n.ticketsAdmin,
                    onTap: () {
                      showCustomBottomModal(
                        context: context,
                        ref: ref,
                        modal: BottomModalTemplate(
                          title: l10n.ticketsAdmin,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Button(
                                text: l10n.ticketsCreate,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  QR.to(
                                    TicketsRouter.root + TicketsRouter.create,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Button(
                                text: l10n.ticketsManageAssociation,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  QR.to(
                                    TicketsRouter.root + TicketsRouter.manage,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          // Section title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                HeroIcon(
                  HeroIcons.ticket,
                  size: 24,
                  color: ColorConstants.gradient1,
                ),
                const SizedBox(width: 10),
                Text(
                  l10n.ticketsMyTickets,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.title,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // TicketEvent list with refresher
          Expanded(
            child: Refresher(
              controller: scrollController,
              onRefresh: () async {
                await userTicketsNotifier.loadUserTickets();
              },
              child: AsyncChild<List<UserTicket>>(
                value: userTicketsAsync,
                builder: (context, tickets) {
                  if (tickets.isEmpty) {
                    return _buildEmptyState(l10n);
                  }
                  final now = DateTime.now();
                  final sortedTickets = [...tickets]..sort((a, b) {
                    final aUpcoming = a.session.startDatetime.isAfter(now);
                    final bUpcoming = b.session.startDatetime.isAfter(now);
                    if (aUpcoming != bUpcoming) {
                      return aUpcoming ? -1 : 1;
                    }
                    return aUpcoming
                        ? a.session.startDatetime.compareTo(
                            b.session.startDatetime,
                          )
                        : b.session.startDatetime.compareTo(
                            a.session.startDatetime,
                          );
                  });
                  return Column(
                    children: [
                      const SizedBox(height: 8),
                      ...sortedTickets.map(
                        (ticket) => UserTicketCard(ticket: ticket),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeroIcon(
              HeroIcons.inbox,
              size: 64,
              color: ColorConstants.onTertiary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.ticketsNoTickets,
              style: TextStyle(
                color: ColorConstants.tertiary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.ticketsNoTicketsSubtitle,
              style: TextStyle(color: ColorConstants.onTertiary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
