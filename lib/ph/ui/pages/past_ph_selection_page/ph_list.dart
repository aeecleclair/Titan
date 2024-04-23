import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_pdf_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_provider.dart';
import 'package:myecl/ph/providers/selected_year_list_provider.dart';
import 'package:myecl/ph/ui/components/year_bar.dart';
import 'package:myecl/ph/ui/pages/past_ph_selection_page/ph_card.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';

class PhList extends HookConsumerWidget {
  const PhList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phList = ref.watch(phListProvider);
    final phPdfNotifier = ref.watch(phPdfProvider.notifier);
    final pdfsNotifier = ref.read(phPdfsProvider.notifier);
    final selectedYear = ref.watch(selectedYearListProvider);

    void displayPhToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
        value: phList,
        builder: (context, phList) {
          final list = phList.where((ph) =>
              selectedYear.contains(ph.date.year) &&
              ph.date.isBefore(DateTime.now()));
          return Column(
            children: [
              const YearBar(),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                    crossAxisCount: kIsWeb ? 5 : 2,
                    children: list.map((ph) {
                      final thePdf =
                          ref.watch(phPdfsProvider.select((map) => map[ph.id]));
                      return AutoLoaderChild(
                        group: thePdf,
                        notifier: pdfsNotifier,
                        mapKey: ph.id,
                        loader: (id) => phPdfNotifier.loadPhPdf(ph.id),
                        dataBuilder: (context, pdf) => PhCard(
                          ph: ph,
                          onDownload: () async {
                            await FileSaver.instance.saveFile(
                                name: ph.name, bytes: pdf.last, ext: "pdf");
                            displayPhToastWithContext(
                                TypeMsg.msg, "Téléchargé avec succès");
                          },
                        ),
                      );
                    }).toList()),
              ),
            ],
          );
        });
  }
}
