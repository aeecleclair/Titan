import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/providers/can_manage_ticket_events_provider.dart';
import 'package:titan/tickets/providers/selected_ticket_event_provider.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tickets/router.dart';
import 'package:titan/tickets/ui/components/ticket_event_status_chip.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class TicketEventCard extends ConsumerWidget {
  final TicketEvent ticketEvent;
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
                  ref.read(selectedTicketEventProvider.notifier).state =
                      ticketEvent;
                  QR.to(TicketsRouter.root + TicketsRouter.results);
                  Navigator.of(context).pop();
                },
              ),
              if (canManageTicketEvents) ...[
                const SizedBox(height: 10),
                Button(
                  text: l10n.ticketsEditTitle,
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    try {
                      final token = ref.read(tokenProvider);
                      final repository = TicketsRepository()..setToken(token);
                      final detailedEvent = await repository.getTicketEventById(
                        ticketEvent.id,
                      );

                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ref.read(selectedTicketEventProvider.notifier).state =
                            detailedEvent;
                        QR.to(TicketsRouter.root + TicketsRouter.edit);
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${l10n.othersError}: ${e.toString()}',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
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
