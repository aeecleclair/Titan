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
  const AssociationAddEditPage({super.key});

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
    final associationGroupementNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final name = useTextEditingController(text: association.name);
    final description = useTextEditingController(text: association.description);

    void showSnackBarWithContext(String message) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    final localizeWithContext = AppLocalizations.of(context)!;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    association.id == ""
                        ? localizeWithContext.phonebookAddAssociation
                        : localizeWithContext.phonebookEdit,
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
                                backgroundColor: Colors.white,
                                backgroundImage: image.image,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  final value = await associationPictureNotifier
                                      .setProfilePicture(
                                        ImageSource.gallery,
                                        association.id,
                                      );
                                  if (value != null) {
                                    if (value) {
                                      showSnackBarWithContext(
                                        localizeWithContext
                                            .settingsUpdatedProfilePicture,
                                      );
                                    } else {
                                      showSnackBarWithContext(
                                        localizeWithContext
                                            .settingsTooHeavyProfilePicture,
                                      );
                                    }
                                  } else {
                                    showSnackBarWithContext(
                                      localizeWithContext
                                          .settingsErrorProfilePicture,
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
                                  final value = await associationPictureNotifier
                                      .setProfilePicture(
                                        ImageSource.camera,
                                        association.id,
                                      );
                                  if (value != null) {
                                    if (value) {
                                      showSnackBarWithContext(
                                        localizeWithContext
                                            .settingsUpdatedProfilePicture,
                                      );
                                    } else {
                                      showSnackBarWithContext(
                                        localizeWithContext
                                            .settingsTooHeavyProfilePicture,
                                      );
                                    }
                                  } else {
                                    showSnackBarWithContext(
                                      localizeWithContext
                                          .settingsErrorProfilePicture,
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
                const SizedBox(height: 20),
                Text(
                  localizeWithContext.phonebookAssociationGroupement,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 5),
                AssociationGroupementBar(editable: true),
                Container(margin: const EdgeInsets.symmetric(vertical: 10)),
                TextEntry(
                  controller: name,
                  label: localizeWithContext.phonebookAssociationName,
                  canBeEmpty: false,
                ),
                const SizedBox(height: 10),
                TextEntry(
                  controller: description,
                  label: localizeWithContext.phonebookDescription,
                  canBeEmpty: true,
                ),
                const SizedBox(height: 50),
                Button(
                  onPressed: () async {
                    if (!key.currentState!.validate()) {
                      showSnackBarWithContext(
                        localizeWithContext.phonebookEmptyFieldError,
                      );
                      return;
                    }
                    if (associationGroupement.id == '') {
                      showSnackBarWithContext(
                        localizeWithContext.phonebookEmptyKindError,
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
                            localizeWithContext.phonebookAddedAssociation,
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
                              localizeWithContext
                                  .phonebookErrorAssociationLoading,
                            ),
                            loading: () {},
                          );
                        } else {
                          showSnackBarWithContext(
                            localizeWithContext.phonebookAddingError,
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
                            localizeWithContext.phonebookUpdatedAssociation,
                          );
                          associationNotifier.setAssociation(
                            association.copyWith(
                              name: name.text,
                              description: description.text,
                              groupementId: associationGroupement.id,
                            ),
                          );
                          associationGroupementNotifier
                              .resetAssociationGroupement();
                          QR.back();
                        } else {
                          showSnackBarWithContext(
                            localizeWithContext.phonebookUpdatingError,
                          );
                        }
                      }
                    });
                  },
                  text: association.id != ""
                      ? localizeWithContext.phonebookEdit
                      : localizeWithContext.phonebookAdd,
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
