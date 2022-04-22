import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/settings/ui/user_field_modifier.dart';
import 'package:myecl/user/models/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

class SettingsForm extends HookConsumerWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(userProvider);
    final dateController = useTextEditingController();
    dateController.text = me.birthday;
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            UserFieldModifier(
              label: "Prénom",
              value: me.firstname,
              keyboardType: TextInputType.text,
            ),
            UserFieldModifier(
                label: "Nom", value: me.name, keyboardType: TextInputType.text),
            UserFieldModifier(
                label: "Surnom",
                value: me.nickname,
                keyboardType: TextInputType.text),
            UserFieldModifier(
                label: "Email",
                value: me.email,
                keyboardType: TextInputType.emailAddress),
            UserFieldModifier(
                label: "Promo",
                value: me.promo.toString(),
                keyboardType: TextInputType.number), //! Surement pas modifiable
            UserFieldModifier(
                label: "Étage",
                value: me.floor,
                keyboardType: TextInputType.text),
            UserFieldModifier(
                label: "Type de compte",
                value: me.groups.map((e) => e.name).join(', '),
                keyboardType: TextInputType.text), //! pas modifiable
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
                        onTap: () => _selectDate(context, me, ref),
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
                value: me.id,
                keyboardType: TextInputType.text), //! Même pas visible
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
