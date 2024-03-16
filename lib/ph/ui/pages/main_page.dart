import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PhMainPage extends HookConsumerWidget {
  const PhMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhTemplate(child: PdfViewer.openAsset('assets/my_document.pdf'));
  }
}
