import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tickets/providers/csv_download_provider.dart';
import 'package:titan/tickets/providers/event_tickets_provider.dart';
import 'package:titan/tickets/providers/selected_ticket_event_provider.dart';
import 'package:titan/tickets/ui/tickets_module.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';

class TicketResultsPage extends HookConsumerWidget {
  const TicketResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedTicketEvent = ref.watch(selectedTicketEventProvider);
    final eventTickets = ref.watch(eventTicketsProvider);
    final eventTicketsNotifier = ref.watch(eventTicketsProvider.notifier);
    final csvDownload = ref.watch(csvDownloadProvider);
    final csvDownloadNotifier = ref.watch(csvDownloadProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    Future<void> downloadCsv() async {
      if (selectedTicketEvent == null) return;

      final bytes = await csvDownloadNotifier.downloadCsv(
        selectedTicketEvent.id,
      );
      if (bytes == null) {
        displayToastWithContext(TypeMsg.error, 'Erreur lors du téléchargement');
        return;
      }

      final path = kIsWeb
          ? await FileSaver.instance.saveFile(
              name: '${selectedTicketEvent.name}_tickets',
              bytes: bytes,
              ext: "csv",
              mimeType: MimeType.csv,
            )
          : await FileSaver.instance.saveAs(
              name: '${selectedTicketEvent.name}_tickets',
              bytes: bytes,
              ext: "csv",
              mimeType: MimeType.csv,
            );

      if (path != null) {
        displayToastWithContext(TypeMsg.msg, 'CSV téléchargé avec succès');
      }
    }

    // Load tickets when the page is first built
    useEffect(() {
      if (selectedTicketEvent != null) {
        eventTicketsNotifier.loadEventTickets(selectedTicketEvent.id);
      }
      return null;
    }, [selectedTicketEvent]);

    // Handle case where no ticketEvent is selected
    if (selectedTicketEvent == null) {
      return TicketTemplate(
        child: Center(
          child: Text(
            l10n.ticketsNotFound,
            style: const TextStyle(color: ColorConstants.tertiary),
          ),
        ),
      );
    }

    return TicketTemplate(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${l10n.ticketsViewResults} - ${selectedTicketEvent.name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Button(
              text: 'Télécharger CSV',
              disabled: csvDownload.isLoading,
              onPressed: () {
                // ignore: avoid-ignoring-return-values
                downloadCsv();
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Refresher(
              onRefresh: () {
                return eventTicketsNotifier.loadEventTickets(
                  selectedTicketEvent.id,
                );
              },
              controller: ScrollController(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AsyncChild(
                  value: eventTickets,
                  builder: (context, tickets) {
                    if (tickets.isEmpty) {
                      return Center(
                        child: Text(
                          l10n.ticketsNoTickets,
                          style: const TextStyle(
                            color: ColorConstants.tertiary,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];
                        return ListItemTemplate(
                          title: '${ticket.userFirstname} ${ticket.userName}',
                          subtitle:
                              '${ticket.category.name} - ${ticket.session.name}',
                          trailing: const SizedBox.shrink(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
