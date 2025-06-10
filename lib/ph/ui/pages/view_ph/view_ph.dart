import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/providers/ph_provider.dart';
import 'package:titan/ph/providers/ph_pdf_provider.dart';
import 'package:titan/ph/ui/pages/ph.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:pdfx/pdfx.dart';

class ViewPhPage extends HookConsumerWidget {
  const ViewPhPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ph = ref.watch(phProvider);
    final phPdf = ref.watch(phPdfProvider(ph.id));

    return AsyncChild(
      value: phPdf,
      builder: (builder, value) => PhTemplate(
        child: PdfView(
          pageSnapping: !kIsWeb,
          scrollDirection: kIsWeb ? Axis.vertical : Axis.horizontal,
          controller: PdfController(document: PdfDocument.openData(value)),
        ),
      ),
    );
  }
}
