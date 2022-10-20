import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/tools/functions.dart';
import 'package:myecl/settings/ui/pages/edit_user_page/user_field_modifier.dart';
import 'package:myecl/settings/ui/refresh_indicator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

class EditUserPage extends HookConsumerWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    final key = GlobalKey<FormFieldState>();
    final asyncUserNotifier = ref.watch(asyncUserProvider.notifier);
    final user = ref.watch(userProvider);
    final dateController = useTextEditingController();
    dateController.text = processDatePrint(user.birthday);
    final firstNameController = useTextEditingController();
    firstNameController.text = user.firstname;
    final nameController = useTextEditingController();
    nameController.text = user.name;
    final nickNameController = useTextEditingController();
    nickNameController.text = user.nickname;
    final floorController = useTextEditingController();
    floorController.text = user.floor.toString();

    void displaySettingsToastWithContext(TypeMsg type, String msg) {
      displaySettingsToast(context, type, msg);
    }

    return SettingsRefresher(
        onRefresh: () async {
          await asyncUserNotifier.loadMe();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
              key: key,
              child: Column(children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Compte",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Photo de profil",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(100)),
                  child: HeroIcon(
                    HeroIcons.user,
                    size: 100,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Ajouter une photo",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFfb6d10)),
                    )),
                const SizedBox(height: 50),
                UserFieldModifier(
                    label: "Prénom",
                    keyboardType: TextInputType.text,
                    controller: firstNameController),
                const SizedBox(height: 50),
                UserFieldModifier(
                    label: "Nom",
                    keyboardType: TextInputType.text,
                    controller: nameController),
                const SizedBox(height: 50),
                UserFieldModifier(
                    label: "Surnom",
                    keyboardType: TextInputType.text,
                    controller: nickNameController),
                const SizedBox(height: 50),
                Row(children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      "Date de naissance",
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
                UserFieldModifier(
                    label: "Etage",
                    keyboardType: TextInputType.text,
                    controller: floorController),
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
                        displaySettingsToastWithContext(
                            TypeMsg.msg, SettingsTextConstants.updatedProfile);
                        pageNotifier.setSettingsPage(SettingsPage.main);
                      } else {
                        displaySettingsToastWithContext(
                            TypeMsg.error, SettingsTextConstants.updatingError);
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
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
                        "Enregistrer",
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
