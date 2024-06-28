import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/providers/ph_pdf_first_page_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_first_page_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/tools/functions.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhCard extends HookConsumerWidget {
  final Ph ph;
  final VoidCallback onDownload;
  const PhCard({
    super.key,
    required this.ph,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ph.id;
    final phNotifier = ref.watch(phProvider.notifier);
    final phPdfFirstPage =
        ref.watch(phPdfsFirstPageProvider.select((map) => map[id]));
    final phPdfsFirstPageNotifier = ref.read(phPdfsFirstPageProvider.notifier);
    final phPdfFirstPageNotifier = ref.read(phPdfFirstPageProvider.notifier);
    return AutoLoaderChild(
      group: phPdfFirstPage,
      notifier: phPdfsFirstPageNotifier,
      mapKey: id,
      loader: (id) => phPdfFirstPageNotifier.loadPhPdfFirstPage(id),
      dataBuilder: (context, cover) {
        return GestureDetector(
          onTap: () {
            phNotifier.setPh(ph);
            QR.to(
              PhRouter.root + PhRouter.past_ph_selection + PhRouter.view_ph,
            );
          },
          child: CardLayout(
            child: Column(
              children: [
                SizedBox(
                  height: kIsWeb ? MediaQuery.of(context).size.width / 7 : 115,
                  child: Image.memory(cover.first),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shortenText(ph.name, 13),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(phFormatDate(ph.date)),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onDownload,
                      child: CardButton(
                        colors: [
                          Colors.grey.shade100,
                          Colors.grey.shade400,
                        ],
                        shadowColor: Colors.grey.shade300.withOpacity(0.2),
                        child: const HeroIcon(
                          HeroIcons.arrowDownTray,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
