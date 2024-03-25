import 'package:flutter/material.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class LastPhPage extends StatelessWidget {
  const LastPhPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhTemplate(child: PdfViewer.openAsset('assets/my_document.pdf'));
  }
}
