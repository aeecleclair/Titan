import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/providers/selected_ticket_event_provider.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tickets/router.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class TicketEventCard extends ConsumerWidget {
  final TicketEvent ticketEvent;
  const TicketEventCard({super.key, required this.ticketEvent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormatter = DateFormat('dd/MM/yyyy HH:mm');

    return ListItem(
      title: ticketEvent.name,
      subtitle:
          '${l10n.ticketsOpeningLabel}: ${dateFormatter.format(ticketEvent.openDatetime)}',
      onTap: () => showCustomBottomModal(
        context: context,
        modal: BottomModalTemplate(
          title: ticketEvent.name,
          child: Column(
            children: [
              Button(
                text: l10n.ticketsViewResults,
                onPressed: () {
                  ref.read(selectedTicketEventProvider.notifier).state =
                      ticketEvent;
                  QR.to(TicketsRouter.root + TicketsRouter.results);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 10),
              Button(
                text: l10n.ticketsEditTitle,
                onPressed: () async {
                  // Charger les détails complets avant d'éditer
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    final token = ref.read(tokenProvider);
                    final repository = TicketsRepository()..setToken(token);
                    final detailedShotgun = await repository.getTicketEventById(
                      ticketEvent.id,
                    );

                    if (context.mounted) {
                      Navigator.of(context).pop(); // Ferme le loader
                      ref.read(selectedTicketEventProvider.notifier).state =
                          detailedShotgun;
                      QR.to(TicketsRouter.root + TicketsRouter.edit);
                      Navigator.of(context).pop(); // Ferme le modal
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Navigator.of(context).pop(); // Ferme le loader
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erreur: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
        ref: ref,
      ),
    );
  }
}
