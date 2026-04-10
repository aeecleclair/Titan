import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/shotgun/providers/csv_download_provider.dart';
import 'package:titan/shotgun/providers/event_tickets_provider.dart';
import 'package:titan/shotgun/providers/selected_shotgun_provider.dart';
import 'package:titan/shotgun/ui/shotgun.dart';
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
    final selectedShotgun = ref.watch(selectedShotgunProvider);
    final eventTickets = ref.watch(eventTicketsProvider);
    final eventTicketsNotifier = ref.watch(eventTicketsProvider.notifier);
    final csvDownload = ref.watch(csvDownloadProvider);
    final csvDownloadNotifier = ref.watch(csvDownloadProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    Future<void> downloadCsv() async {
      if (selectedShotgun == null) return;

      final bytes = await csvDownloadNotifier.downloadCsv(selectedShotgun.id);
      if (bytes == null) {
        displayToastWithContext(TypeMsg.error, 'Erreur lors du téléchargement');
        return;
      }

      final path = kIsWeb
          ? await FileSaver.instance.saveFile(
              name: '${selectedShotgun.name}_tickets',
              bytes: bytes,
              ext: "csv",
              mimeType: MimeType.csv,
            )
          : await FileSaver.instance.saveAs(
              name: '${selectedShotgun.name}_tickets',
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
      if (selectedShotgun != null) {
        eventTicketsNotifier.loadEventTickets(selectedShotgun.id);
      }
      return null;
    }, [selectedShotgun]);

    // Handle case where no shotgun is selected
    if (selectedShotgun == null) {
      return ShotgunTemplate(
        child: Center(
          child: Text(
            l10n.shotgunNotFound,
            style: const TextStyle(color: ColorConstants.tertiary),
          ),
        ),
      );
    }

    return ShotgunTemplate(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${l10n.shotgunViewResults} - ${selectedShotgun.name}',
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
                  selectedShotgun.id,
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
                          l10n.shotgunNoTickets,
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
