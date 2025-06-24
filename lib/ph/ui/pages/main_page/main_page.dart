import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/providers/is_ph_admin_provider.dart';
import 'package:titan/ph/providers/ph_list_provider.dart';
import 'package:titan/ph/providers/ph_pdf_provider.dart';
import 'package:titan/ph/router.dart';
import 'package:titan/ph/tools/constants.dart';
import 'package:titan/ph/ui/button.dart';
import 'package:titan/ph/ui/pages/ph.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:pdfx/pdfx.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhMainPage extends HookConsumerWidget {
  const PhMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isPhAdminProvider);
    final phList = ref.watch(phListProvider);

    return PhTemplate(
      child: Column(
        children: [
          if (isAdmin)
            SizedBox(
              width: 116.7,
              child: AdminButton(
                onTap: () {
                  QR.to(PhRouter.root + PhRouter.admin);
                },
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: 250,
            child: GestureDetector(
              onTap: () {
                QR.to(PhRouter.root + PhRouter.past_ph_selection);
              },
              child: const MyButton(text: PhTextConstants.seePreviousJournal),
            ),
          ),
          const SizedBox(height: 10),
          AsyncChild(
            value: phList,
            builder: (context, phs) {
              phs.sort((a, b) => a.date.compareTo(b.date));
              if (phs.isEmpty) {
                return const Text(PhTextConstants.noJournalInDatabase);
              } else {
                final idLastPh = phs.last.id;
                final lastPhPdf = ref.watch(phPdfProvider(idLastPh));

                return AsyncChild(
                  value: lastPhPdf,
                  builder: (context, value) => Expanded(
                    child: PdfView(
                      pageSnapping: !kIsWeb,
                      controller: PdfController(
                        document: PdfDocument.openData(value),
                      ),
                      scrollDirection: kIsWeb ? Axis.vertical : Axis.horizontal,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
