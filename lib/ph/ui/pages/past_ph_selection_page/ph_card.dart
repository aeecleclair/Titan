import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/providers/ph_cover_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/providers/ph_pdf_provider.dart';
import 'package:myecl/ph/router.dart';
import 'package:myecl/ph/tools/constants.dart';
import 'package:myecl/ph/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhCard extends HookConsumerWidget {
  final Ph ph;

  const PhCard({
    super.key,
    required this.ph,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phId = ph.id;
    final phCover = ref.watch(phCoverProvider(phId));
    final phPdf = ref.watch(phPdfProvider(phId).future);
    final phNotifier = ref.read(phProvider.notifier);

    void displayPhToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

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
              child: AsyncChild(
                value: phCover,
                builder: (context, value) => Image.memory(value),
              ),
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
                  onTap: () async {
                    late final Uint8List pdfBytes;

                    try {
                      pdfBytes = await phPdf;
                    } catch (e) {
                      displayPhToastWithContext(
                        TypeMsg.error,
                        e.toString(),
                      );
                      return;
                    }

                    final path = kIsWeb
                        ? await FileSaver.instance.saveFile(
                            name: ph.name,
                            bytes: pdfBytes,
                            ext: "pdf",
                            mimeType: MimeType.pdf,
                          )
                        : await FileSaver.instance.saveAs(
                            name: ph.name,
                            bytes: pdfBytes,
                            ext: "pdf",
                            mimeType: MimeType.pdf,
                          );

                    if (path != null) {
                      displayPhToastWithContext(
                        TypeMsg.msg,
                        PhTextConstants.succesDowloading,
                      );
                    }
                  },
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
  }
}
