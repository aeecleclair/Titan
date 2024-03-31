import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_pdf_provider.dart';
import 'package:myecl/ph/providers/ph_pdfs_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/ui/pages/add_ph_page/add_page.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PhAddEditPhPage extends HookConsumerWidget {
  const PhAddEditPhPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ph = ref.watch(phProvider);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController(text: ph.name);

    final phPdfs = ref.watch(phPdfsProvider);
    final phListNotifier = ref.watch(phListProvider.notifier);
    final phPdfNotifier = ref.watch(phPdfProvider.notifier);
    final phPdf = useState<Uint8List?>(null);
    final phPdfFile = useState<SfPdfViewer?>(null);

    if (phPdfs[ph.id] != null) {
      phPdfs[ph.id]!.whenData((data) {
        if (data.isNotEmpty) {
          phPdfFile.value = data.first;
        }
      });
    }

    void displayPhToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextEntry(
                      maxLines: 1,
                      label: "Hello",
                      controller: name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormField<File>(
                      validator: (e) {
                        if (phPdf.value == null) {
                          return "Hello";
                        }
                        return null;
                      },
                      builder: (formFieldState) => Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            PdfPicker(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      WaitingButton(
                        onTap: () async {
                          if (key.currentState == null) {
                            return;
                          }
                          if (key.currentState!.validate() &&
                              (phPdf.value != null)) {
                            await tokenExpireWrapper(ref, () async {
                              final phList = ref.watch(phListProvider);
                              Ph newPh = Ph(
                                  id: '',
                                  date: DateTime.now(),
                                  name: name.text);
                              final value = await phListNotifier.addPh(newPh);
                              if (value) {
                                QR.back();
                                {
                                  displayPhToastWithContext(
                                      TypeMsg.msg, "Salut");
                                  phList.maybeWhen(
                                      data: (list) {
                                        final newPh = list.last;
                                        phPdfNotifier.updatePhPdf(
                                            newPh.id, phPdf.value!);
                                      },
                                      orElse: () {});
                                }
                              } else {
                                displayPhToastWithContext(TypeMsg.error, 'Yop');
                              }
                            });
                          } else {
                            displayToast(context, TypeMsg.error, "Team");
                          }
                        },
                        child: const Text("carotte",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        builder: (child) => AddEditButtonLayout(child: child),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
