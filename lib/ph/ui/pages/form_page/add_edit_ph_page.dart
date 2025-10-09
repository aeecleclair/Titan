import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/class/ph.dart';
import 'package:titan/ph/providers/ph_list_provider.dart';
import 'package:titan/ph/providers/ph_pdf_provider.dart';
import 'package:titan/ph/providers/ph_send_pdf_provider.dart';
import 'package:titan/ph/providers/ph_provider.dart';
import 'package:titan/ph/providers/edit_pdf_provider.dart';
import 'package:titan/ph/tools/constants.dart';
import 'package:titan/ph/tools/functions.dart';
import 'package:titan/ph/ui/pages/file_picker/pdf_picker.dart';
import 'package:titan/ph/ui/pages/ph.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhAddEditPhPage extends HookConsumerWidget {
  const PhAddEditPhPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ph = ref.watch(phProvider);
    final isEdit = ph.id != Ph.empty().id;
    final dateController = TextEditingController(
      text: phFormatDateEntry(ph.date),
    );
    final key = GlobalKey<FormState>();
    final name = useTextEditingController(text: ph.name);

    final phListNotifier = ref.watch(phListProvider.notifier);
    final phSendPdf = ref.watch(phSendPdfProvider);
    final editPdfNotifier = ref.watch(editPdfProvider.notifier);
    final editPdf = ref.watch(editPdfProvider);

    void displayPhToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhTemplate(
      child: Form(
        key: key,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextEntry(
                      maxLines: 1,
                      label: PhTextConstants.phName,
                      controller: name,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          DateEntry(
                            label: PhTextConstants.date,
                            controller: dateController,
                            onTap: () {
                              getOnlyDayDate(
                                context,
                                dateController,
                                firstDate: DateTime.utc(1890),
                                lastDate: DateTime.utc(2100),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          PdfPicker(isEdit: isEdit),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Spacer(),
                    WaitingButton(
                      onTap: () async {
                        if (key.currentState == null) {
                          return;
                        }
                        if (true &&
                            (!listEquals(phSendPdf, Uint8List(0)) || isEdit)) {
                          await tokenExpireWrapper(ref, () async {
                            final phList = ref.watch(phListProvider);
                            Ph newPh = Ph(
                              id: isEdit ? ph.id : '',
                              date: DateTime.parse(
                                processDateBack(dateController.text),
                              ),
                              name: name.text,
                            );
                            final value = isEdit
                                ? await phListNotifier.editPh(newPh)
                                : await phListNotifier.addPh(newPh);

                            if (value) {
                              SystemChannels.textInput.invokeMethod(
                                'TextInput.hide',
                              );
                              QR.back();
                              {
                                if (editPdf) {
                                  phList.maybeWhen(
                                    data: (list) {
                                      ref
                                          .read(
                                            phPdfProvider(
                                              list.last.id,
                                            ).notifier,
                                          )
                                          .updatePhPdf(
                                            Uint8List.fromList(phSendPdf),
                                          );
                                    },
                                    orElse: () {},
                                  );
                                }
                                displayPhToastWithContext(
                                  TypeMsg.msg,
                                  isEdit
                                      ? PhTextConstants.edited
                                      : PhTextConstants.added,
                                );
                                editPdfNotifier.editPdf(false);
                              }
                            } else {
                              displayPhToastWithContext(
                                TypeMsg.error,
                                PhTextConstants.addingFileError,
                              );
                            }
                          });
                        } else {
                          displayToast(
                            context,
                            TypeMsg.error,
                            PhTextConstants.missingInformatonsOrPdf,
                          );
                        }
                      },
                      child: Text(
                        isEdit ? PhTextConstants.edit : PhTextConstants.add,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      builder: (child) => AddEditButtonLayout(child: child),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
