import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/settings/ui/pages/main_page/picture_button.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/user/providers/profile_picture_provider.dart';
import 'package:titan/user/providers/user_provider.dart';

class EditProfile extends HookConsumerWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
    final profilePicture = ref.watch(profilePictureProvider);
    final asyncUserNotifier = ref.watch(asyncUserProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final emailController = useTextEditingController(text: me.email);
    final phoneController = useTextEditingController(text: me.phone ?? '');
    final birthdayController = useTextEditingController(
      text: me.birthday != null
          ? "${me.birthday!.day.toString().padLeft(2, '0')}/${me.birthday!.month.toString().padLeft(2, '0')}/${me.birthday!.year}"
          : '',
    );

    MediaQuery.of(context).viewInsets.bottom;

    final localizeWithContext = AppLocalizations.of(context)!;
    final navigatorWithContext = Navigator.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (View.of(context).viewInsets.bottom == 0)
              AsyncChild(
                value: profilePicture,
                builder: (context, profile) {
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
                            backgroundImage: profile.isEmpty
                                ? const AssetImage('assets/images/profile.png')
                                : Image.memory(profile).image,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: GestureDetector(
                            onTap: () async {
                              final value = await profilePictureNotifier
                                  .setProfilePicture(ImageSource.gallery);
                              if (value != null) {
                                if (value) {
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    localizeWithContext
                                        .settingsUpdatedProfilePicture,
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    localizeWithContext
                                        .settingsTooHeavyProfilePicture,
                                  );
                                }
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext
                                      .settingsErrorProfilePicture,
                                );
                              }
                            },
                            child: const PictureButton(icon: HeroIcons.photo),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              final value = await profilePictureNotifier
                                  .setProfilePicture(ImageSource.camera);
                              if (value != null) {
                                if (value) {
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    localizeWithContext
                                        .settingsUpdatedProfilePicture,
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    localizeWithContext
                                        .settingsTooHeavyProfilePicture,
                                  );
                                }
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext
                                      .settingsErrorProfilePicture,
                                );
                              }
                            },
                            child: const PictureButton(icon: HeroIcons.camera),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          right: 60,
                          child: GestureDetector(
                            onTap: () async {
                              final value = await profilePictureNotifier
                                  .cropImage();
                              if (value != null) {
                                if (value) {
                                  displayToastWithContext(
                                    TypeMsg.msg,
                                    localizeWithContext
                                        .settingsUpdatedProfilePicture,
                                  );
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    localizeWithContext
                                        .settingsErrorProfilePicture,
                                  );
                                }
                              }
                            },
                            child: const PictureButton(
                              icon: HeroIcons.sparkles,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            SizedBox(height: View.of(context).viewInsets.bottom == 0 ? 30 : 10),
            TextEntry(
              label: localizeWithContext.settingsEmail,
              controller: emailController,
              enabled: false,
            ),
            SizedBox(height: 20),
            TextEntry(
              label: localizeWithContext.settingsPhoneNumber,
              controller: phoneController,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextEntry(
                    label: localizeWithContext.settingsBirthday,
                    controller: birthdayController,
                    enabled: false,
                  ),
                ),
                CustomIconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2004),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      birthdayController.text =
                          "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Button(
              text: localizeWithContext.settingsValidate,
              disabled:
                  !(phoneController.value.text != me.phone ||
                      birthdayController.value.text !=
                          "${me.birthday!.day.toString().padLeft(2, '0')}/${me.birthday!.month.toString().padLeft(2, '0')}/${me.birthday!.year}"),
              onPressed: () async {
                if (phoneController.value.text != me.phone ||
                    birthdayController.value.text.isNotEmpty) {
                  await tokenExpireWrapper(ref, () async {
                    final newMe = me.copyWith(
                      birthday: birthdayController.value.text.isNotEmpty
                          ? DateTime.parse(
                              processDateBack(birthdayController.value.text),
                            )
                          : null,
                      phone: phoneController.value.text.isEmpty
                          ? null
                          : phoneController.value.text,
                    );
                    final value = await asyncUserNotifier.updateMe(newMe);
                    if (value) {
                      displayToastWithContext(
                        TypeMsg.msg,
                        localizeWithContext.settingsEditedAccount,
                      );
                      navigatorWithContext.pop();
                    } else {
                      displayToastWithContext(
                        TypeMsg.error,
                        localizeWithContext.settingsFailedToEditAccount,
                      );
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
