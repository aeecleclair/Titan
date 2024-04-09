import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_pdf_provider.dart';
import 'package:myecl/ph/providers/ph_send_pdf_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/tools/functions.dart';
import 'package:myecl/ph/ui/pages/file_picker/pdf_picker.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/date_entry.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhAddEditPhPage extends HookConsumerWidget {
  const PhAddEditPhPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ph = ref.watch(phProvider);
    final isEdit = ph.id != Ph.empty().id;
    final dateController =
        TextEditingController(text: phFormatDateEntry(ph.date));
    final key = GlobalKey<FormState>();
    final name = useTextEditingController(text: ph.name);

    final phListNotifier = ref.watch(phListProvider.notifier);
    final phPdfNotifier = ref.watch(phPdfProvider.notifier);
    final phSendPdf = ref.watch(phSendPdfProvider);

    void displayPhToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhTemplate(
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
                    label: "Nom du PH",
                    controller: name,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        DateEntry(
                            label: "Date",
                            controller: dateController,
                            onTap: () {
                              getOnlyDayDate(context, dateController,
                                  firstDate: DateTime.utc(1890),
                                  lastDate: DateTime.utc(2100));
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        PdfPicker(isEdit: isEdit),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 362,
                  child: Column(
                    children: [
                      const Spacer(),
                      WaitingButton(
                        onTap: () async {
                          if (key.currentState == null) {
                            return;
                          }
                          if (true &&
                              (!listEquals(phSendPdf, Uint8List(0)) ||
                                  isEdit)) {
                            await tokenExpireWrapper(ref, () async {
                              final phList = ref.watch(phListProvider);
                              Ph newPh = Ph(
                                  id: isEdit ? ph.id : '',
                                  date: DateTime.parse(
                                      processDateBack(dateController.text)),
                                  name: name.text);
                              final value = isEdit
                                  ? await phListNotifier.editPh(newPh)
                                  : await phListNotifier.addPh(newPh);

                              if (value) {
                                QR.back();
                                {
                                  displayPhToastWithContext(TypeMsg.msg,
                                      isEdit ? "Modifié" : "Ajouté");
                                  phList.maybeWhen(
                                      data: (list) {
                                        final newPh = list.last;
                                        phPdfNotifier.updatePhPdf(
                                            newPh.id, phSendPdf);
                                      },
                                      orElse: () {});
                                }
                              } else {
                                displayPhToastWithContext(
                                    TypeMsg.error, "Erreur d'ajout");
                              }
                            });
                          } else {
                            displayToast(context, TypeMsg.error,
                                "Informations manquantes ou fichier PDF manquant");
                          }
                        },
                        child: Text(isEdit ? "Modifier" : "Ajouter",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        builder: (child) => AddEditButtonLayout(child: child),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
