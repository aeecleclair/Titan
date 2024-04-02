import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:pdfx/pdfx.dart';

class ViewPhPage extends HookConsumerWidget {
  const ViewPhPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PhTemplate(child: Pdf());
  }
}

class Pdf extends StatelessWidget {
  const Pdf({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfController = PdfController(
        document: PdfDocument.openAsset('assets/my_document.pdf'));
    return RotatedBox(
        quarterTurns: 3, child: PdfView(controller: pdfController));
  }
}
