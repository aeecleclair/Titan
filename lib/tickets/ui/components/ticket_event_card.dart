import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tickets/adapters/ticket_event.dart';
import 'package:titan/tickets/providers/can_manage_ticket_events_provider.dart';
import 'package:titan/tickets/providers/selected_ticket_event_provider.dart';
import 'package:titan/tickets/router.dart';
import 'package:titan/tickets/ui/components/ticket_event_status_chip.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class TicketEventCard extends ConsumerWidget {
  final EventSimple ticketEvent;
  const TicketEventCard({super.key, required this.ticketEvent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm');
    final canManageTicketEvents = ref.watch(canManageTicketEventsProvider);

    return ListItemTemplate(
      title: ticketEvent.name,
      subtitle:
          '${l10n.ticketsOpeningLabel}: ${dateFormatter.format(ticketEvent.openDatetime)}',
      trailing: TicketEventStatusChip(status: ticketEvent.status),
      onTap: () => showCustomBottomModal(
        context: context,
        modal: BottomModalTemplate(
          title: ticketEvent.name,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TicketEventStatusChip(status: ticketEvent.status),
              ),
              const SizedBox(height: 12),
              Button(
                text: l10n.ticketsViewResults,
                onPressed: () {
                  ref
                      .read(selectedTicketEventIdProvider.notifier)
                      .setId(ticketEvent.id);
                  QR.to(TicketsRouter.root + TicketsRouter.results);
                  Navigator.of(context).pop();
                },
              ),
              if (canManageTicketEvents) ...[
                const SizedBox(height: 10),
                Button(
                  text: l10n.ticketsEditTitle,
                  onPressed: () {
                    ref
                        .read(selectedTicketEventIdProvider.notifier)
                        .setId(ticketEvent.id);
                    QR.to(TicketsRouter.root + TicketsRouter.edit);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ],
          ),
        ),
        ref: ref,
      ),
    );
  }
}
