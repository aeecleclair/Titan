import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_poster_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/pages/advert.dart';
import 'package:myecl/advert/ui/components/announcer_bar.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AdvertAddEditAdvertPage extends HookConsumerWidget {
  const AdvertAddEditAdvertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advert = ref.watch(advertProvider);
    final key = GlobalKey<FormState>();
    final isEdit = advert.id != Advert.empty().id;
    final title = useTextEditingController(text: advert.title);
    final content = useTextEditingController(text: advert.content);
    final selectedAnnouncers = ref.watch(announcerProvider);

    final tags = advert.tags;
    var textTags = tags.join(', ');
    final textTagsController = useTextEditingController(text: textTags);

    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final posterNotifier = ref.watch(advertPosterProvider.notifier);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final poster = useState<Uint8List?>(null);
    final posterFile = useState<Image?>(null);

    ref.watch(advertPostersProvider).whenData((value) {
      if (value[advert] != null) {
        value[advert]!.whenData((data) {
          if (data.isNotEmpty) {
            posterFile.value = data.first;
          }
        });
      }
    });
    final ImagePicker picker = ImagePicker();

    void displayAdvertToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdvertTemplate(
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
                      label: AdvertTextConstants.title,
                      controller: title,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormField<File>(
                      validator: (e) {
                        if (poster.value == null && !isEdit) {
                          return AdvertTextConstants.choosingPoster;
                        }
                        return null;
                      },
                      builder: (formFieldState) => Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  if (kIsWeb) {
                                    poster.value = await image.readAsBytes();
                                    posterFile.value =
                                        Image.network(image.path);
                                  } else {
                                    final file = File(image.path);
                                    poster.value = await file.readAsBytes();
                                    posterFile.value = Image.file(file);
                                  }
                                }
                              },
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
                                              image: DecorationImage(
                                                image: poster.value != null
                                                    ? Image.memory(
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
                      label: AdvertTextConstants.content,
                      controller: content,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              FormField<List<Announcer>>(
                validator: (e) {
                  if (selectedAnnouncers.isEmpty) {
                    return AdvertTextConstants.choosingAnnouncer;
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
                        label: AdvertTextConstants.tags,
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
                              final advertList = ref.watch(advertListProvider);
                              Advert newAdvert = Advert(
                                  id: isEdit ? advert.id : '',
                                  announcer: selectedAnnouncers[0],
                                  content: content.text,
                                  date: DateTime.now(),
                                  tags: textTagsController.text.split(', '),
                                  title: title.text);
                              final value = isEdit
                                  ? await advertListNotifier
                                      .updateAdvert(newAdvert)
                                  : await advertListNotifier
                                      .addAdvert(newAdvert);
                              if (value) {
                                QR.back();
                                if (isEdit) {
                                  displayAdvertToastWithContext(TypeMsg.msg,
                                      AdvertTextConstants.editedAdvert);
                                  advertList.maybeWhen(
                                    data: (list) {
                                      if (poster.value != null) {
                                        posterNotifier.updateAdvertPoster(
                                            advert.id, poster.value!);
                                        advertPostersNotifier.setTData(
                                            advert,
                                            AsyncData([
                                              Image.memory(
                                                poster.value!,
                                                fit: BoxFit.cover,
                                              ),
                                            ]));
                                      }
                                    },
                                    orElse: () {},
                                  );
                                } else {
                                  displayAdvertToastWithContext(TypeMsg.msg,
                                      AdvertTextConstants.addedAdvert);
                                  advertList.maybeWhen(
                                      data: (list) {
                                        final newAdvert = list.last;
                                        posterNotifier.updateAdvertPoster(
                                            newAdvert.id, poster.value!);
                                        advertPostersNotifier.setTData(
                                            newAdvert,
                                            AsyncData([
                                              Image.memory(
                                                poster.value!,
                                                fit: BoxFit.cover,
                                              )
                                            ]));
                                      },
                                      orElse: () {});
                                }
                              } else {
                                displayAdvertToastWithContext(TypeMsg.error,
                                    AdvertTextConstants.editingError);
                              }
                            });
                          } else {
                            displayToast(context, TypeMsg.error,
                                AdvertTextConstants.incorrectOrMissingFields);
                          }
                        },
                        child: Text(
                            isEdit
                                ? AdvertTextConstants.edit
                                : AdvertTextConstants.add,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        builder: (child) => Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 8, bottom: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: child),
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
