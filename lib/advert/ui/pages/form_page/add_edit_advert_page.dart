import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/advert/providers/advert_poster_provider.dart';
import 'package:myecl/advert/providers/advert_posters_provider.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/tools/announcer_bar.dart';
import 'package:myecl/advert/ui/pages/form_page/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
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
    final selectedAnnoncers = ref.watch(announcerProvider);

    final tags = advert.tags;
    var textTags = tags.join(', ');
    final textTagsController = useTextEditingController(text: textTags);

    final advertListNotifier = ref.watch(advertListProvider.notifier);
    final posterNotifier = ref.watch(advertPosterProvider.notifier);
    final advertPostersNotifier = ref.watch(advertPostersProvider.notifier);
    final poster = useState<Uint8List?>(null);
    final posterFile = useState<Image?>(null);

    //final selected = ref.watch(announcerProvider);

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

    return Expanded(
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
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      label: AdvertTextConstants.title,
                      suffix: '',
                      isInt: false,
                      controller: title,
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            child: posterFile.value != null
                                ? Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
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
                                  )
                                : const HeroIcon(
                                    HeroIcons.photo,
                                    size: 160,
                                    color: Colors.grey,
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: GestureDetector(
                              onTap: () async {
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  poster.value =
                                      await File(image.path).readAsBytes();
                                  posterFile.value =
                                      Image.file(File(image.path));
                                }
                              },
                              child: Container(
                                height: 160,
                                width: 160,
                                padding: const EdgeInsets.all(7),
                                child: const HeroIcon(
                                  HeroIcons.photo,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextEntry(
                      minLines: 5,
                      maxLines: 50,
                      keyboardType: TextInputType.multiline,
                      label: AdvertTextConstants.content,
                      suffix: '',
                      isInt: false,
                      controller: content,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const AnnouncerBar(
                useUserAnnouncers: true,
                multipleSelect: false,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextEntry(
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        label: AdvertTextConstants.tags,
                        suffix: '',
                        isInt: false,
                        controller: textTagsController,
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ShrinkButton(
                        waitChild: Container(
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
                                offset: const Offset(
                                    3, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (key.currentState == null) {
                            return;
                          }
                          if (key.currentState!.validate()) {
                            await tokenExpireWrapper(ref, () async {
                              final advertList = ref.watch(advertListProvider);
                              Advert newAdvert = Advert(
                                  id: isEdit ? advert.id : '',
                                  announcer: selectedAnnoncers[0],
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
                                ;
                                if (isEdit) {
                                  displayAdvertToastWithContext(TypeMsg.msg,
                                      AdvertTextConstants.editedAdvert);
                                  advertList.when(
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
                                      error: (error, s) {},
                                      loading: () {});
                                } else {
                                  displayAdvertToastWithContext(TypeMsg.msg,
                                      AdvertTextConstants.addedAdvert);
                                  advertList.when(
                                      data: (list) {
                                        final newAdvert = list.last;
                                        if (poster.value != null) {
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
                                        }
                                      },
                                      error: (error, s) {},
                                      loading: () {});
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
                        child: Container(
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
                                  offset: const Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text(
                                isEdit
                                    ? AdvertTextConstants.edit
                                    : AdvertTextConstants.add,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
