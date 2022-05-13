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
    final meNotifier = ref.watch(userProvider.notifier).lastLoadedUser;
    final dateController = useTextEditingController();
    dateController.text = meNotifier.birthday;
    final idController = useTextEditingController();
    idController.text = meNotifier.id;
    final firstNameController = useTextEditingController();
    firstNameController.text = meNotifier.firstname;
    final nameController = useTextEditingController();
    nameController.text = meNotifier.name;
    final nickNameController = useTextEditingController();
    nickNameController.text = meNotifier.nickname;
    final emailController = useTextEditingController();
    emailController.text = meNotifier.email;
    final promoController = useTextEditingController();
    promoController.text = meNotifier.promo.toString();
    final floorController = useTextEditingController();
    floorController.text = meNotifier.floor.toString();
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            UserFieldModifier(
              label: "Préname",
              controller: firstNameController,
              keyboardType: TextInputType.text,
            ),
            UserFieldModifier(
                label: "name",
                controller: nameController,
                keyboardType: TextInputType.text),
            UserFieldModifier(
                label: "Surname",
                controller: nickNameController,
                keyboardType: TextInputType.text),
            UserFieldModifier(
                label: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress),
            UserFieldModifier(
                label: "Promo",
                controller: promoController,
                keyboardType: TextInputType.number), //! Surement pas modifiable
            UserFieldModifier(
                label: "Étage",
                controller: floorController,
                keyboardType: TextInputType.text),
            // UserFieldModifier(
            //     label: "Type de compte",
            //     controller: ,
            //     keyboardType: TextInputType.text), //! pas modifiable
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const Text(
                          "Date de naissance",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 158, 158, 158),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context, meNotifier, ref),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: dateController,
                              // initialValue: dateController.value.text,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today),
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
                            ),
                          ),
                        ),
                      ),
                    ])),
            UserFieldModifier(
              label: "Id",
              keyboardType: TextInputType.text,
              controller: idController,
            ), //! Même pas visible
            ElevatedButton(
              onPressed: () {
                ref
                    .read(userProvider.notifier)
                    .updateUser(meNotifier.copyWith(
                      birthday: dateController.value.text,
                      id: idController.value.text,
                      firstname: firstNameController.value.text,
                      name: nameController.value.text,
                      nickname: nickNameController.value.text,
                      email: emailController.value.text,
                      promo: int.parse(promoController.value.text),
                      floor: floorController.value.text,
                    ))
                    .then((value) => value.when(
                          data: (d) => displayToast(
                              context, TypeMsg.msg, "Profil modifié"),
                          error: (e, s) => displayToast(context, TypeMsg.error,
                              "Erreur lors de la modification du profil"),
                          loading: () {},
                        ));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 158, 158, 158),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context, User me, WidgetRef ref) async {
    final meNotifier = ref.watch(userProvider.notifier);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(me.birthday),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    meNotifier.updateUser(me.copyWith(
        birthday: picked == null
            ? me.birthday
            : DateFormat('yyyy-MM-dd').format(picked)));
  }
}
