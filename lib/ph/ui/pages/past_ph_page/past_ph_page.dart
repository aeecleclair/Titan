import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PastPhPage extends HookConsumerWidget {
  const PastPhPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhTemplate(child: SfPdfViewer.asset('assets/my_document.pdf'));
  }
}
