import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/class/announcer.dart';
import 'package:myecl/ph/providers/ph_list_provider.dart';
import 'package:myecl/ph/providers/ph_poster_provider.dart';
import 'package:myecl/ph/providers/ph_posters_provider.dart';
import 'package:myecl/ph/providers/ph_provider.dart';
import 'package:myecl/ph/providers/announcer_provider.dart';
import 'package:myecl/ph/tools/constants.dart';
import 'package:myecl/ph/ui/pages/ph.dart';
import 'package:myecl/ph/ui/components/announcer_bar.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/image_picker_on_tap.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PhAddEditPhPage extends HookConsumerWidget {
  const PhAddEditPhPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ph = ref.watch(phProvider);
    final key = GlobalKey<FormState>();
    final isEdit = ph.id != Ph.empty().id;
    final title = useTextEditingController(text: ph.title);
    final content = useTextEditingController(text: ph.content);
    final selectedAnnouncers = ref.watch(announcerProvider);

    final tags = ph.tags;
    var textTags = tags.join(', ');
    final textTagsController = useTextEditingController(text: textTags);
    final phPdfs = ref.watch(phPdfsProvider);
    final phListNotifier = ref.watch(phListProvider.notifier);
    final posterNotifier = ref.watch(phPdfProvider.notifier);
    final poster = useState<Uint8List?>(null);
    final posterFile = useState<SfPdfViewer?>(null);

    if (phPdfs[ph.id] != null) {
      phPdfs[ph.id]!.whenData((data) {
        if (data.isNotEmpty) {
          posterFile.value = data.first;
        }
      });
    }

    final SfPdfViewerPicker picker = SfPdfViewerPicker();

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
                      label: PhTextConstants.title,
                      controller: title,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormField<File>(
                      validator: (e) {
                        if (poster.value == null && !isEdit) {
                          return PhTextConstants.choosingPoster;
                        }
                        return null;
                      },
                      builder: (formFieldState) => Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SfPdfViewerPickerOnTap(
                              picker: picker,
                              imageBytesNotifier: poster,
                              imageNotifier: posterFile,
                              displayToastWithContext:
                                  displayPhToastWithContext,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: formFieldState.hasError
                                          ? Colors.red
                                          : Colors.black.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(2, 3),
                                    ),
                                  ],
                                ),
                                child: posterFile.value != null
                                    ? Stack(
                                        children: [
                                          Container(
                                            width: 285,
                                            height: 160,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              image: DecorationSfPdfViewer(
                                                image: poster.value != null
                                                    ? SfPdfViewer.memory(
                                                        poster.value!,
                                                        fit: BoxFit.cover,
                                                      ).image
                                                    : posterFile.value!.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: Colors.white
                                                      .withOpacity(0.4),
                                                ),
                                                child: HeroIcon(
                                                  HeroIcons.photo,
                                                  size: 40,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const HeroIcon(
                                        HeroIcons.photo,
                                        size: 160,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextEntry(
                      minLines: 5,
                      maxLines: 50,
                      keyboardType: TextInputType.multiline,
                      label: PhTextConstants.content,
                      controller: content,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              FormField<List<Announcer>>(
                validator: (e) {
                  if (selectedAnnouncers.isEmpty) {
                    return PhTextConstants.choosingAnnouncer;
                  }
                  return null;
                },
                builder: (formFieldState) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: formFieldState.hasError
                        ? [
                            const BoxShadow(
                              color: Colors.red,
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(2, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: AnnouncerBar(
                    useUserAnnouncers: true,
                    multipleSelect: false,
                    isNotClickable: isEdit,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextEntry(
                        maxLines: 1,
                        label: PhTextConstants.tags,
                        canBeEmpty: true,
                        controller: textTagsController,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      WaitingButton(
                        onTap: () async {
                          if (key.currentState == null) {
                            return;
                          }
                          if (key.currentState!.validate() &&
                              selectedAnnouncers.isNotEmpty &&
                              (poster.value != null || isEdit)) {
                            await tokenExpireWrapper(ref, () async {
                              final phList = ref.watch(phListProvider);
                              Ph newPh = Ph(
                                  id: isEdit ? ph.id : '',
                                  announcer: selectedAnnouncers[0],
                                  content: content.text,
                                  date: isEdit ? ph.date : DateTime.now(),
                                  tags: textTagsController.text.split(', '),
                                  title: title.text);
                              final value = isEdit
                                  ? await phListNotifier.updatePh(newPh)
                                  : await phListNotifier.addPh(newPh);
                              if (value) {
                                QR.back();
                                if (isEdit) {
                                  displayPhToastWithContext(
                                      TypeMsg.msg, PhTextConstants.editedPh);
                                  phList.maybeWhen(
                                    data: (list) {
                                      if (poster.value != null) {
                                        posterNotifier.updatePhPdf(
                                            ph.id, poster.value!);
                                      }
                                    },
                                    orElse: () {},
                                  );
                                } else {
                                  displayPhToastWithContext(
                                      TypeMsg.msg, PhTextConstants.addedPh);
                                  phList.maybeWhen(
                                      data: (list) {
                                        final newPh = list.last;
                                        posterNotifier.updatePhPdf(
                                            newPh.id, poster.value!);
                                      },
                                      orElse: () {});
                                }
                              } else {
                                displayPhToastWithContext(TypeMsg.error,
                                    PhTextConstants.editingError);
                              }
                            });
                          } else {
                            displayToast(context, TypeMsg.error,
                                PhTextConstants.incorrectOrMissingFields);
                          }
                        },
                        child: Text(
                            isEdit ? PhTextConstants.edit : PhTextConstants.add,
                            style: const TextStyle(
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
