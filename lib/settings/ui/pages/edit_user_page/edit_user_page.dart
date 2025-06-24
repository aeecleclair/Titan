import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/settings/router.dart';
import 'package:titan/settings/tools/constants.dart';
import 'package:titan/settings/ui/pages/edit_user_page/picture_button.dart';
import 'package:titan/settings/ui/pages/edit_user_page/user_field_modifier.dart';
import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/user/class/floors.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:titan/user/providers/profile_picture_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EditUserPage extends HookConsumerWidget {
  const EditUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormFieldState>();
    final asyncUserNotifier = ref.watch(asyncUserProvider.notifier);
    final user = ref.watch(userProvider);
    final profilePicture = ref.watch(profilePictureProvider);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
    final dateController = useTextEditingController(
      text: user.birthday != null ? processDate(user.birthday!) : "",
    );
    final nickNameController = useTextEditingController(
      text: user.nickname ?? '',
    );
    final phoneController = useTextEditingController(text: user.phone ?? '');
    final floorController = useTextEditingController(
      text: user.floor.toString(),
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    List<DropdownMenuItem> items = Floors.values
        .map(
          (e) => DropdownMenuItem(
            value: capitalize(e.toString().split('.').last),
            child: Text(capitalize(e.toString().split('.').last)),
          ),
        )
        .toList();

    return SettingsTemplate(
      child: Refresher(
        onRefresh: () async {
          await asyncUserNotifier.loadMe();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: key,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const AlignLeftText(
                  SettingsTextConstants.editAccount,
                  color: Colors.grey,
                ),
                const SizedBox(height: 40),
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
                                  ? const AssetImage(
                                      'assets/images/profile.png',
                                    )
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
                                      SettingsTextConstants
                                          .updatedProfilePicture,
                                    );
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      SettingsTextConstants
                                          .tooHeavyProfilePicture,
                                    );
                                  }
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    SettingsTextConstants.errorProfilePicture,
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
                                      SettingsTextConstants
                                          .updatedProfilePicture,
                                    );
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      SettingsTextConstants
                                          .tooHeavyProfilePicture,
                                    );
                                  }
                                } else {
                                  displayToastWithContext(
                                    TypeMsg.error,
                                    SettingsTextConstants.errorProfilePicture,
                                  );
                                }
                              },
                              child: const PictureButton(
                                icon: HeroIcons.camera,
                              ),
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
                                      SettingsTextConstants
                                          .updatedProfilePicture,
                                    );
                                  } else {
                                    displayToastWithContext(
                                      TypeMsg.error,
                                      SettingsTextConstants.errorProfilePicture,
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
                const SizedBox(height: 50),
                if (user.promo != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      '${SettingsTextConstants.promo} ${user.promo}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                AutoSizeText(
                  '${SettingsTextConstants.email} : ${user.email}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 50),
                UserFieldModifier(
                  label: SettingsTextConstants.nickname,
                  keyboardType: TextInputType.text,
                  controller: nickNameController,
                ),
                const SizedBox(height: 50),
                UserFieldModifier(
                  label: SettingsTextConstants.phone,
                  keyboardType: TextInputType.text,
                  controller: phoneController,
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        SettingsTextConstants.birthday,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AbsorbPointer(
                        child: TextEntry(
                          label: SettingsTextConstants.birthday,
                          controller: dateController,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => getOnlyDayDate(
                        context,
                        dateController,
                        initialDate: user.birthday,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 30),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              ColorConstants.gradient1,
                              ColorConstants.gradient2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.gradient2.withValues(
                                alpha: 0.5,
                              ),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const HeroIcon(
                          HeroIcons.calendar,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        SettingsTextConstants.floor,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        items: items,
                        value: floorController.text,
                        hint: Text(
                          SettingsTextConstants.floor,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        onChanged: (value) {
                          floorController.text = value.toString();
                        },
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade800,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorConstants.gradient1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                WaitingButton(
                  builder: (child) => AddEditButtonLayout(
                    colors: const [
                      ColorConstants.gradient1,
                      ColorConstants.gradient2,
                    ],
                    child: child,
                  ),
                  onTap: () async {
                    await tokenExpireWrapper(ref, () async {
                      final value = await asyncUserNotifier.updateMe(
                        user.copyWith(
                          birthday: dateController.value.text.isNotEmpty
                              ? DateTime.parse(
                                  processDateBack(dateController.value.text),
                                )
                              : null,
                          nickname: nickNameController.value.text.isEmpty
                              ? null
                              : nickNameController.value.text,
                          phone: phoneController.value.text.isEmpty
                              ? null
                              : phoneController.value.text,
                          floor: floorController.value.text,
                        ),
                      );
                      if (value) {
                        displayToastWithContext(
                          TypeMsg.msg,
                          SettingsTextConstants.updatedProfile,
                        );
                        QR.removeNavigator(
                          SettingsRouter.root + SettingsRouter.editAccount,
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          SettingsTextConstants.updatingError,
                        );
                      }
                    });
                  },
                  child: const Center(
                    child: Text(
                      SettingsTextConstants.save,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
