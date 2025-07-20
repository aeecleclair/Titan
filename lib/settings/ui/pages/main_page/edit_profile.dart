import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/settings/ui/pages/main_page/picture_button.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/user/providers/profile_picture_provider.dart';

class EditProfile extends ConsumerWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
    final profilePicture = ref.watch(profilePictureProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Column(
      children: [
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
                              AppLocalizations.of(
                                context,
                              )!.settingsUpdatedProfilePicture,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              AppLocalizations.of(
                                context,
                              )!.settingsTooHeavyProfilePicture,
                            );
                          }
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            AppLocalizations.of(
                              context,
                            )!.settingsErrorProfilePicture,
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
                              AppLocalizations.of(
                                context,
                              )!.settingsUpdatedProfilePicture,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              AppLocalizations.of(
                                context,
                              )!.settingsTooHeavyProfilePicture,
                            );
                          }
                        } else {
                          displayToastWithContext(
                            TypeMsg.error,
                            AppLocalizations.of(
                              context,
                            )!.settingsErrorProfilePicture,
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
                        final value = await profilePictureNotifier.cropImage();
                        if (value != null) {
                          if (value) {
                            displayToastWithContext(
                              TypeMsg.msg,
                              AppLocalizations.of(
                                context,
                              )!.settingsUpdatedProfilePicture,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              AppLocalizations.of(
                                context,
                              )!.settingsErrorProfilePicture,
                            );
                          }
                        }
                      },
                      child: const PictureButton(icon: HeroIcons.sparkles),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
