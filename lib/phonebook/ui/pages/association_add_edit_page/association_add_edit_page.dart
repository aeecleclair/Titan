import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/ui/components/groupement_bar.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/settings/ui/pages/edit_user_page/picture_button.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';

class AssociationAddEditPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationAddEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associations = ref.watch(associationListProvider);
    final association = ref.watch(associationProvider);
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationPicture = ref.watch(associationPictureProvider);
    final associationPictureNotifier = ref.watch(
      associationPictureProvider.notifier,
    );
    final associationGroupement = ref.watch(associationGroupementProvider);
    final name = useTextEditingController(text: association.name);
    final description = useTextEditingController(text: association.description);

    void showSnackBarWithContext(String message) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    AppLocalizations localizeWithContext() {
      return AppLocalizations.of(context)!;
    }

    return PhonebookTemplate(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Form(
          key: key,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    association.id == ""
                        ? AppLocalizations.of(context)!.phonebookAddAssociation
                        : AppLocalizations.of(context)!.phonebookEdit,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.title,
                    ),
                  ),
                ),
                if (association.id != "") ...[
                  const SizedBox(height: 30),
                  AsyncChild(
                    value: associationPicture,
                    builder: (context, image) {
                      return Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: image.image,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  final updatedProfilePictureMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.settingsUpdatedProfilePicture;
                                  final tooHeavyProfilePictureMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.settingsTooHeavyProfilePicture;
                                  final profilePictureErrorMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.settingsErrorProfilePicture;
                                  final value = await associationPictureNotifier
                                      .setProfilePicture(
                                        ImageSource.gallery,
                                        association.id,
                                      );
                                  if (value != null) {
                                    if (value) {
                                      showSnackBarWithContext(
                                        updatedProfilePictureMsg,
                                      );
                                    } else {
                                      showSnackBarWithContext(
                                        tooHeavyProfilePictureMsg,
                                      );
                                    }
                                  } else {
                                    showSnackBarWithContext(
                                      profilePictureErrorMsg,
                                    );
                                  }
                                },
                                child: const PictureButton(
                                  icon: HeroIcons.photo,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  final updatedProfilePictureMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.settingsUpdatedProfilePicture;
                                  final tooHeavyProfilePictureMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.settingsTooHeavyProfilePicture;
                                  final profilePictureErrorMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.settingsErrorProfilePicture;
                                  final value = await associationPictureNotifier
                                      .setProfilePicture(
                                        ImageSource.camera,
                                        association.id,
                                      );
                                  if (value != null) {
                                    if (value) {
                                      showSnackBarWithContext(
                                        updatedProfilePictureMsg,
                                      );
                                    } else {
                                      showSnackBarWithContext(
                                        tooHeavyProfilePictureMsg,
                                      );
                                    }
                                  } else {
                                    showSnackBarWithContext(
                                      profilePictureErrorMsg,
                                    );
                                  }
                                },
                                child: const PictureButton(
                                  icon: HeroIcons.camera,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 30),
                AssociationGroupementBar(editable: true),
                Container(margin: const EdgeInsets.symmetric(vertical: 10)),
                TextEntry(
                  controller: name,
                  label: AppLocalizations.of(context)!.phonebookName,
                  canBeEmpty: false,
                ),
                const SizedBox(height: 30),
                TextEntry(
                  controller: description,
                  label: AppLocalizations.of(context)!.phonebookDescription,
                  canBeEmpty: true,
                ),
                const SizedBox(height: 50),
                Button(
                  onPressed: () async {
                    if (!key.currentState!.validate()) {
                      showSnackBarWithContext(
                        AppLocalizations.of(context)!.phonebookEmptyFieldError,
                      );
                      return;
                    }
                    if (associationGroupement.id == '') {
                      showSnackBarWithContext(
                        AppLocalizations.of(context)!.phonebookEmptyKindError,
                      );
                      return;
                    }
                    await tokenExpireWrapper(ref, () async {
                      if (association.id == '') {
                        final value = await associationListNotifier
                            .createAssociation(
                              association.copyWith(
                                name: name.text,
                                description: description.text,
                                groupementId: associationGroupement.id,
                                mandateYear: DateTime.now().year,
                              ),
                            );
                        if (value) {
                          showSnackBarWithContext(
                            localizeWithContext().phonebookAddedAssociation,
                          );
                          associations.when(
                            data: (d) {
                              associationNotifier.setAssociation(d.last);
                              QR.to(
                                PhonebookRouter.root +
                                    PhonebookRouter.admin +
                                    PhonebookRouter.addEditAssociation,
                              );
                            },
                            error: (e, s) => showSnackBarWithContext(
                              AppLocalizations.of(
                                context,
                              )!.phonebookErrorAssociationLoading,
                            ),
                            loading: () {},
                          );
                        } else {
                          showSnackBarWithContext(
                            localizeWithContext().phonebookAddingError,
                          );
                        }
                      } else {
                        final value = await associationListNotifier
                            .updateAssociation(
                              association.copyWith(
                                name: name.text,
                                description: description.text,
                                groupementId: associationGroupement.id,
                              ),
                            );
                        if (value) {
                          showSnackBarWithContext(
                            localizeWithContext().phonebookUpdatedAssociation,
                          );
                          QR.to(PhonebookRouter.root + PhonebookRouter.admin);
                        } else {
                          showSnackBarWithContext(
                            localizeWithContext().phonebookUpdatingError,
                          );
                        }
                      }
                    });
                  },
                  text: AppLocalizations.of(context)!.adminAdd,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
