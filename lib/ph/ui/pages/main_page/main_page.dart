import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/providers/is_ph_admin_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/ui/button.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhMainPage extends HookConsumerWidget {
  const PhMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isPhAdminProvider);
    return PhTemplate(
        child: Column(
      children: [
        if (true)
          SizedBox(
            width: 116.7,
            child: AdminButton(
              onTap: () {
                QR.to(PhRouter.root + PhRouter.admin);
              },
            ),
          ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            QR.to(PhRouter.root + PhRouter.past_ph_selection);
          },
          child: const MyButton(
            text: "Voir les anciens journaux",
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: MediaQuery.sizeOf(context).height - 320,
            child: SfPdfViewer.asset('assets/my_document.pdf',
                pageLayoutMode: PdfPageLayoutMode.single)),
      ],
    ));
  }
}
