import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/edit_user_page/user_field_modifier.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/user/repositories/profile_picture_repository.dart';

class EditUserPage extends HookConsumerWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    final key = GlobalKey<FormFieldState>();
    final asyncUserNotifier = ref.watch(asyncUserProvider.notifier);
    final user = ref.watch(userProvider);
    final profilePicture = ref.watch(profilePictureProvider);
    final profilePictureNotifier = ref.watch(profilePictureProvider.notifier);
    final dateController =
        useTextEditingController(text: processDatePrint(user.birthday));
    final firstNameController = useTextEditingController(text: user.firstname);
    final nameController = useTextEditingController(text: user.name);
    final nickNameController = useTextEditingController(text: user.nickname);
    final floorController =
        useTextEditingController(text: user.floor.toString());

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    List<DropdownMenuItem> items = [
      "Adoma",
      "Exté",
      "T1",
      "T2",
      "T3",
      "T4",
      "T56",
      "U1",
      "U2",
      "U3",
      "U4",
      "U56",
      "V1",
      "V2",
      "V3",
      "V45",
      "V6",
      "X1",
      "X2",
      "X3",
      "X4",
      "X5",
      "X6",
    ]
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList();

    return Refresher(
        onRefresh: () async {
          await asyncUserNotifier.loadMe();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
              key: key,
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(SettingsTextConstants.editAccount,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 205, 205, 205))),
                ),
                const SizedBox(height: 40),
                profilePicture.when(data: (profile) {
                  return Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
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
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(profile),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              final file = await profilePictureNotifier
                                  .setProfilePicture(File(""));
                              if (file is AsyncData) {
                                displayToastWithContext(
                                    TypeMsg.msg, "Photo de profil changée");
                              } else {
                                displayToastWithContext(
                                    TypeMsg.error, "Erreur lors du changement");
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
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
                                    color: ColorConstants.gradient2
                                        .withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }, loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }, error: (e, s) {
                  return const Center(
                    child:
                        Text("Erreur lors du chargement de la photo de profil"),
                  );
                }),
                const SizedBox(height: 50),
                UserFieldModifier(
                    label: SettingsTextConstants.firstname,
                    keyboardType: TextInputType.text,
                    controller: firstNameController),
                const SizedBox(height: 50),
                UserFieldModifier(
                    label: SettingsTextConstants.name,
                    keyboardType: TextInputType.text,
                    controller: nameController),
                const SizedBox(height: 50),
                UserFieldModifier(
                    label: SettingsTextConstants.nickname,
                    keyboardType: TextInputType.text,
                    controller: nickNameController),
                const SizedBox(height: 50),
                Row(children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      SettingsTextConstants.birthday,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500),
                    ),
                  ),
                  Expanded(
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 158, 158, 158),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return SettingsTextConstants.expectingDate;
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => _selectDate(context, user, dateController),
                      child: Container(
                          margin: const EdgeInsets.only(left: 30),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFfb6d10), Color(0xffeb3e1b)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xffeb3e1b).withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: const HeroIcon(
                            HeroIcons.calendar,
                            size: 25,
                            color: Colors.white,
                          ))),
                ]),
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
                            color: Colors.grey.shade500),
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
                              color: Colors.grey.shade500),
                        ),
                        onChanged: (value) {
                          floorController.text = value.toString();
                        },
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade800),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFfb6d10)))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    tokenExpireWrapper(ref, () async {
                      final value =
                          await asyncUserNotifier.updateMe(user.copyWith(
                        birthday: processDateBack(dateController.value.text),
                        firstname: firstNameController.value.text,
                        name: nameController.value.text,
                        nickname: nickNameController.value.text,
                        floor: floorController.value.text,
                      ));
                      if (value) {
                        displayToastWithContext(
                            TypeMsg.msg, SettingsTextConstants.updatedProfile);
                        pageNotifier.setSettingsPage(SettingsPage.main);
                      } else {
                        displayToastWithContext(
                            TypeMsg.error, SettingsTextConstants.updatingError);
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        bottom: 12, top: 8, right: 12, left: 12),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFfb6d10), Color(0xffeb3e1b)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffeb3e1b).withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        SettingsTextConstants.save,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
              ])),
        ));
  }

  _selectDate(BuildContext context, User me,
      TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(me.birthday),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFFfb6d10),
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    dateController.text = picked == null
        ? me.birthday
        : processDatePrint(DateFormat('yyyy-MM-dd').format(picked));
  }
}
