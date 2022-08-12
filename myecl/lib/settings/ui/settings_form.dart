import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/settings/ui/user_field_modifier.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

class SettingsForm extends HookConsumerWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserNotifier = ref.watch(asyncUserProvider.notifier);
    final user = ref.watch(userProvider);
    final asyncUser = ref.watch(asyncUserProvider);
    final dateController = useTextEditingController();
    dateController.text = user.birthday;
    final idController = useTextEditingController();
    idController.text = user.id;
    final firstNameController = useTextEditingController();
    firstNameController.text = user.firstname;
    final nameController = useTextEditingController();
    nameController.text = user.name;
    final nickNameController = useTextEditingController();
    nickNameController.text = user.nickname;
    final emailController = useTextEditingController();
    emailController.text = user.email;
    final promoController = useTextEditingController();
    promoController.text = user.promo.toString();
    final floorController = useTextEditingController();
    floorController.text = user.floor.toString();
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            UserFieldModifier(
              label: "Prénom",
              controller: firstNameController,
              keyboardType: TextInputType.text,
            ),
            UserFieldModifier(
                label: "Nom",
                controller: nameController,
                keyboardType: TextInputType.text),
            UserFieldModifier(
                label: "Surnom",
                controller: nickNameController,
                keyboardType: TextInputType.text),
            UserFieldModifier(
                label: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress),
            UserFieldModifier(
                label: "Promotion",
                controller: promoController,
                keyboardType: TextInputType.number), //! Surement pas modifiable
            UserFieldModifier(
                label: "Étage",
                controller: floorController,
                keyboardType: TextInputType.text),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 3),
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          "Date de naissance",
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
                              // initialValue: dateController.value.text,
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
                                  return "Please enter a date for your task";
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
                asyncUserNotifier.updateMe(user.copyWith(
                  birthday: dateController.value.text,
                  id: idController.value.text,
                  firstname: firstNameController.value.text,
                  name: nameController.value.text,
                  nickname: nickNameController.value.text,
                  email: emailController.value.text,
                  promo: int.parse(promoController.value.text),
                  floor: floorController.value.text,
                ));
                asyncUser.when(
                  data: (d) =>
                      displayToast(context, TypeMsg.msg, "Profil modifié"),
                  error: (e, s) => displayToast(context, TypeMsg.error,
                      "Erreur lors de la modification du profil"),
                  loading: () {},
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 53, 165, 209),
                      Color.fromARGB(255, 23, 138, 238),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: const Text(
                  "Enregistrer",
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
    dateController.text =
        picked == null ? me.birthday : DateFormat('yyyy-MM-dd').format(picked);
  }
}
