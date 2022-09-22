import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/tools/functions.dart';
import 'package:myecl/settings/ui/pages/info_page/user_field_modifier.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

class InfoPage extends HookConsumerWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    final asyncUserNotifier = ref.watch(asyncUserProvider.notifier);
    final user = ref.watch(userProvider);
    final asyncUser = ref.watch(asyncUserProvider);
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          UserFieldModifier(
            label: SettingsTextConstants.firstname,
            controller: firstNameController,
            keyboardType: TextInputType.text,
          ),
          UserFieldModifier(
              label: SettingsTextConstants.name,
              controller: nameController,
              keyboardType: TextInputType.text),
          UserFieldModifier(
              label: SettingsTextConstants.nickname,
              controller: nickNameController,
              keyboardType: TextInputType.text),
          UserFieldModifier(
              label: SettingsTextConstants.floor,
              controller: floorController,
              keyboardType: TextInputType.text),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 3),
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text(
                        SettingsTextConstants.birthday,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 158, 158, 158),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context, user, dateController),
                      child: SizedBox(
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
                    ),
                  ])),
          GestureDetector(
            onTap: () {
              tokenExpireWrapper(ref, () async {
                await asyncUserNotifier.updateMe(user.copyWith(
                  birthday: processDateBack(dateController.value.text),
                  firstname: firstNameController.value.text,
                  name: nameController.value.text,
                  nickname: nickNameController.value.text,
                  floor: floorController.value.text,
                ));
                asyncUser.when(
                  data: (d) {
                    displaySettingsToast(context, TypeMsg.msg,
                        SettingsTextConstants.updatedProfile);
                    pageNotifier.setSettingsPage(SettingsPage.main);
                  },
                  error: (e, s) => displaySettingsToast(context, TypeMsg.error,
                      SettingsTextConstants.updatingError),
                  loading: () {},
                );
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient:  const LinearGradient(
                  colors: [
                    SettingsColorConstants.gradient1,
                    SettingsColorConstants.gradient2,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: SettingsColorConstants.gradient2.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                SettingsTextConstants.save,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context, User me,
      TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(me.birthday),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    dateController.text = picked == null
        ? me.birthday
        : processDatePrint(DateFormat('yyyy-MM-dd').format(picked));
  }
}
