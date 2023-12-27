import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecl/recommendation/class/recommendation.dart';
import 'package:myecl/recommendation/providers/recommendation_list_provider.dart';
import 'package:myecl/recommendation/providers/recommendation_logo_map_provider.dart';
import 'package:myecl/recommendation/providers/recommendation_logo_provider.dart';
import 'package:myecl/recommendation/providers/recommendation_provider.dart';
import 'package:myecl/recommendation/tools/constants.dart';
import 'package:myecl/recommendation/ui/widgets/recommendation_template.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditRecommendationPage extends HookConsumerWidget {
  const AddEditRecommendationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const maxFileSize = 4194304;
    final formKey = GlobalKey<FormState>();
    final ImagePicker picker = ImagePicker();
    final recommendation = ref.watch(recommendationProvider);
    final recommendationNotifier = ref.watch(recommendationProvider.notifier);
    final recommendationList = ref.watch(recommendationListProvider);
    final recommendationListNotifier =
        ref.watch(recommendationListProvider.notifier);
    final recommendationLogoNotifier =
        ref.watch(recommendationLogoProvider.notifier);
    final recommendationLogoMapNotifier =
        ref.watch(recommendationLogoMapProvider.notifier);
    final logo = useState<Uint8List?>(null);
    final logoFile = useState<Image?>(null);
    final isEdit = recommendation.id != Recommendation.empty().id;

    final title = useTextEditingController(text: recommendation.title);
    final code = useTextEditingController(text: recommendation.code);
    final summary = useTextEditingController(text: recommendation.summary);
    final description =
        useTextEditingController(text: recommendation.description);

    ref.watch(recommendationLogoMapProvider).whenData(
      (value) {
        if (value[recommendation] != null) {
          value[recommendation]!.whenData(
            (data) {
              if (data.isNotEmpty) {
                logoFile.value = data.first;
              }
            },
          );
        }
      },
    );

    void displayAdvertToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return RecommendationTemplate(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextEntry(
                  maxLines: 1,
                  label: RecommendationTextConstants.title,
                  controller: title,
                ),
                const SizedBox(height: 30),
                FormField<File>(
                  validator: (e) {
                    if (logo.value == null && !isEdit) {
                      return RecommendationTextConstants.addImage;
                    }
                    return null;
                  },
                  builder: (formFieldState) => Center(
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          final size = await image.length();
                          if (size > maxFileSize) {
                            displayAdvertToastWithContext(TypeMsg.error,
                                RecommendationTextConstants.imageSizeTooBig);
                          } else {
                            if (kIsWeb) {
                              logo.value = await image.readAsBytes();
                              logoFile.value = Image.network(image.path);
                            } else {
                              final file = File(image.path);
                              logo.value = await file.readAsBytes();
                              logoFile.value = Image.file(file);
                            }
                          }
                        }
                      },
                      child: logoFile.value != null
                          ? Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                image: DecorationImage(
                                  image: logo.value != null
                                      ? Image.memory(logo.value!).image
                                      : logoFile.value!.image,
                                ),
                              ),
                            )
                          : const HeroIcon(
                              HeroIcons.photo,
                              size: 100,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                ),
                TextEntry(
                  maxLines: 1,
                  label: RecommendationTextConstants.code,
                  controller: code,
                ),
                const SizedBox(height: 30),
                TextEntry(
                  minLines: 1,
                  maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  label: RecommendationTextConstants.summary,
                  controller: summary,
                ),
                const SizedBox(height: 30),
                TextEntry(
                  minLines: 5,
                  maxLines: 50,
                  keyboardType: TextInputType.multiline,
                  label: RecommendationTextConstants.description,
                  controller: description,
                ),
                const SizedBox(height: 50),
                WaitingButton(
                  child: Text(
                    isEdit
                        ? RecommendationTextConstants.edit
                        : RecommendationTextConstants.add,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      Recommendation newRecommendation = Recommendation(
                        id: recommendation.id,
                        creation: recommendation.creation,
                        title: title.text,
                        code: code.text,
                        summary: summary.text,
                        description: description.text,
                      );
                      final value = isEdit
                          ? await recommendationListNotifier
                              .updateRecommendation(newRecommendation)
                          : await recommendationListNotifier
                              .addRecommendation(newRecommendation);
                      if (value) {
                        if (isEdit) {
                          recommendationNotifier
                              .setRecommendation(newRecommendation);
                          displayAdvertToastWithContext(TypeMsg.msg,
                              RecommendationTextConstants.editedRecommendation);
                          recommendationList.maybeWhen(
                            data: (list) {
                              if (logo.value != null) {
                                recommendationLogoNotifier
                                    .updateRecommendationLogo(
                                        recommendation.id!, logo.value!);
                                recommendationLogoMapNotifier.setTData(
                                  recommendation,
                                  AsyncData([Image.memory(logo.value!)]),
                                );
                              }
                            },
                            orElse: () {},
                          );
                        } else {
                          displayAdvertToastWithContext(TypeMsg.msg,
                              RecommendationTextConstants.addedRecommendation);
                          recommendationList.maybeWhen(
                            data: (list) {
                              final newRecommendation = list.last;
                              recommendationLogoNotifier
                                  .updateRecommendationLogo(
                                      newRecommendation.id!, logo.value!);
                              recommendationLogoMapNotifier.setTData(
                                newRecommendation,
                                AsyncData([Image.memory(logo.value!)]),
                              );
                            },
                            orElse: () {},
                          );
                        }
                        QR.back();
                      } else {
                        displayAdvertToastWithContext(
                          TypeMsg.error,
                          isEdit
                              ? RecommendationTextConstants.editingError
                              : RecommendationTextConstants.addingError,
                        );
                      }
                    } else {
                      displayToast(context, TypeMsg.error,
                          RecommendationTextConstants.incorrectOrMissingFields);
                    }
                  },
                  builder: (child) => AddEditButtonLayout(child: child),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
