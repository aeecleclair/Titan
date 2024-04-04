import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_pdf_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_provider.dart';
import 'package:myecl/ph/ui/pages/past_ph_selection_page/ph_card.dart';
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
    return AsyncChild(
        value: phList,
        builder: (context, phList) {
          return Column(
              children: phList.map((ph) {
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
                  await FileSaver.instance
                      .saveFile(name: ph.name, bytes: pdf.last, ext: "pdf");
                },
              ),
            );
          }).toList());
        });
  }
}
