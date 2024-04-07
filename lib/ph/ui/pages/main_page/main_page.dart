import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/providers/is_ph_admin_provider.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_pdf_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/ui/button.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:pdfx/pdfx.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhMainPage extends HookConsumerWidget {
  const PhMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(isPhAdminProvider);
    final phList = ref.watch(phListProvider);
    final phPdfNotifier = ref.watch(phPdfProvider.notifier);
    final rotation = useState(false);
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
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: GestureDetector(
                onTap: () {
                  QR.to(PhRouter.root + PhRouter.past_ph_selection);
                },
                child: const MyButton(
                  text: "Voir les anciens journaux",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                rotation.value = !rotation.value;
              },
              child: const HeroIcon(HeroIcons.arrowPathRoundedSquare,
                  color: Colors.black),
            )
          ],
        ),
        const SizedBox(height: 10),
        AsyncChild(
            value: phList,
            builder: (context, phs) {
              phs.sort((b, a) => a.date.compareTo(b.date));
              final id = phs.last.id;
              final lastPdf =
                  ref.watch(phPdfsProvider.select((map) => map[id]));
              final pdfsNotifier = ref.read(phPdfsProvider.notifier);
              if (id != Ph.empty().id) {
                return rotation.value
                    ? Transform.rotate(
                        angle: pi / 2,
                        child: Container(
                          height: MediaQuery.of(context).size.height - 300,
                          width: 1000,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: AutoLoaderChild(
                              group: lastPdf,
                              notifier: pdfsNotifier,
                              mapKey: id,
                              loader: (id) => phPdfNotifier.loadPhPdf(id),
                              dataBuilder: (context, pdf) => PdfView(
                                    pageSnapping: false,
                                    controller: PdfController(
                                        viewportFraction: 0.9,
                                        document:
                                            PdfDocument.openData(pdf.last)),
                                    scrollDirection: kIsWeb
                                        ? Axis.vertical
                                        : Axis.horizontal,
                                  )),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 289,
                        child: AutoLoaderChild(
                            group: lastPdf,
                            notifier: pdfsNotifier,
                            mapKey: id,
                            loader: (id) => phPdfNotifier.loadPhPdf(id),
                            dataBuilder: (context, pdf) => PdfView(
                                  pageSnapping: false,
                                  controller: PdfController(
                                      document: PdfDocument.openData(pdf.last)),
                                  scrollDirection:
                                      kIsWeb ? Axis.vertical : Axis.horizontal,
                                )),
                      );
              } else {
                return const Text("Pas encore de Ph dans la base de donnée");
              }
            })
      ],
    ));
  }
}
