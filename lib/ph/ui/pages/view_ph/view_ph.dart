import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_pdf_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:pdfx/pdfx.dart';

class ViewPhPage extends HookConsumerWidget {
  const ViewPhPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ph = ref.watch(phProvider);
    final id = ph.id;
    final phList = ref.watch(phListProvider);
    final phPdfNotifier = ref.watch(phPdfProvider.notifier);
    return PhTemplate(
      child: AsyncChild(
        value: phList,
        builder: (context, phs) {
          final choosenPdf = ref.watch(phPdfsProvider.select((map) => map[id]));
          final pdfNotifier = ref.read(phPdfsProvider.notifier);
          return Expanded(
            child: AutoLoaderChild(
              group: choosenPdf,
              notifier: pdfNotifier,
              mapKey: id,
              loader: (id) => phPdfNotifier.loadPhPdf(id),
              dataBuilder: (context, pdf) => PdfView(
                pageSnapping: false,
                scrollDirection: kIsWeb ? Axis.vertical : Axis.horizontal,
                controller: PdfController(
                  document: PdfDocument.openData(pdf.last),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
