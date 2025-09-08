import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/recommendation/class/recommendation.dart';
import 'package:titan/recommendation/providers/recommendation_list_provider.dart';
import 'package:titan/recommendation/providers/recommendation_logo_map_provider.dart';
import 'package:titan/recommendation/providers/recommendation_logo_provider.dart';
import 'package:titan/recommendation/providers/recommendation_provider.dart';
import 'package:titan/recommendation/tools/constants.dart';
import 'package:titan/recommendation/ui/widgets/recommendation_template.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/image_picker_on_tap.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditRecommendationPage extends HookConsumerWidget {
  const AddEditRecommendationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final ImagePicker picker = ImagePicker();
    final recommendation = ref.watch(recommendationProvider);
    final recommendationNotifier = ref.watch(recommendationProvider.notifier);
    final recommendationList = ref.watch(recommendationListProvider);
    final recommendationListNotifier = ref.watch(
      recommendationListProvider.notifier,
    );
    final recommendationLogoNotifier = ref.watch(
      recommendationLogoProvider.notifier,
    );
    final logoBytes = useState<Uint8List?>(null);
    final logo = useState<Image?>(null);
    final isEdit = recommendation.id != Recommendation.empty().id;

    final title = useTextEditingController(text: recommendation.title);
    final code = useTextEditingController(text: recommendation.code);
    final summary = useTextEditingController(text: recommendation.summary);
    final description = useTextEditingController(
      text: recommendation.description,
    );

    final recommendationLogoMap = ref.watch(recommendationLogoMapProvider);

    if (recommendationLogoMap[recommendation] != null) {
      recommendationLogoMap[recommendation]!.whenData((data) {
        if (data.isNotEmpty) {
          logo.value = data.first;
        }
      });
    }

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
                    if (logoBytes.value == null && !isEdit) {
                      return RecommendationTextConstants.addImage;
                    }
                    return null;
                  },
                  builder: (formFieldState) => Center(
                    child: ImagePickerOnTap(
                      imageBytesNotifier: logoBytes,
                      imageNotifier: logo,
                      displayToastWithContext: displayAdvertToastWithContext,
                      picker: picker,
                      child: logo.value != null
                          ? Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                image: DecorationImage(
                                  image: logoBytes.value != null
                                      ? Image.memory(logoBytes.value!).image
                                      : logo.value!.image,
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
                  canBeEmpty: true,
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
                        code: code.text == "" ? null : code.text,
                        summary: summary.text,
                        description: description.text,
                      );
                      final value = isEdit
                          ? await recommendationListNotifier
                                .updateRecommendation(newRecommendation)
                          : await recommendationListNotifier.addRecommendation(
                              newRecommendation,
                            );
                      if (value) {
                        if (isEdit) {
                          recommendationNotifier.setRecommendation(
                            newRecommendation,
                          );
                          displayAdvertToastWithContext(
                            TypeMsg.msg,
                            RecommendationTextConstants.editedRecommendation,
                          );
                          recommendationList.maybeWhen(
                            data: (list) {
                              if (logoBytes.value != null) {
                                recommendationLogoNotifier
                                    .updateRecommendationLogo(
                                      recommendation.id!,
                                      logoBytes.value!,
                                    );
                              }
                            },
                            orElse: () {},
                          );
                        } else {
                          displayAdvertToastWithContext(
                            TypeMsg.msg,
                            RecommendationTextConstants.addedRecommendation,
                          );
                          recommendationList.maybeWhen(
                            data: (list) {
                              final newRecommendation = list.last;
                              recommendationLogoNotifier
                                  .updateRecommendationLogo(
                                    newRecommendation.id!,
                                    logoBytes.value!,
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
                      displayToast(
                        context,
                        TypeMsg.error,
                        RecommendationTextConstants.incorrectOrMissingFields,
                      );
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
