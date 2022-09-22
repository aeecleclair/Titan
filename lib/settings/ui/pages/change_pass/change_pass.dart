import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/providers/settings_page_provider.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/tools/dialog.dart';
import 'package:myecl/settings/tools/functions.dart';
import 'package:myecl/settings/ui/pages/change_pass/test_entry_style.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

class ChangePassPage extends HookConsumerWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(settingsPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final oldPassword = useTextEditingController();
    final newPassword = useTextEditingController();
    final confirmPassword = useTextEditingController();
    final hideOldPass = useState(true);
    final hideNewPass = useState(true);
    final hideConfirmPass = useState(true);
    final userNotifier = ref.watch(asyncUserProvider.notifier);
    final user = ref.watch(userProvider);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: key,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    SettingsTextConstants.changePassword,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    decoration: changePassInputDecoration(
                        hintText: SettingsTextConstants.oldPassword,
                        notifier: hideOldPass),
                    controller: oldPassword,
                    obscureText: hideOldPass.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return SettingsTextConstants.emptyField;
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    decoration: changePassInputDecoration(
                        hintText: SettingsTextConstants.newPassword,
                        notifier: hideNewPass),
                    controller: newPassword,
                    obscureText: hideNewPass.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return SettingsTextConstants.emptyField;
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    decoration: changePassInputDecoration(
                        hintText: SettingsTextConstants.confirmPassword,
                        notifier: hideConfirmPass),
                    controller: confirmPassword,
                    obscureText: hideConfirmPass.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return SettingsTextConstants.emptyField;
                      } else if (value != newPassword.text) {
                        return SettingsTextConstants.passwordsNotMatch;
                      }
                      return null;
                    },
                  )),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  if (key.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) => SettignsDialog(
                              descriptions:
                                  SettingsTextConstants.changingPassword,
                              onYes: () {
                                tokenExpireWrapper(ref, () async {
                                  final value = await userNotifier.changePassword(
                                      oldPassword.text, newPassword.text, user);
                                  if (value) {
                                    pageNotifier
                                        .setSettingsPage(SettingsPage.main);
                                    displaySettingsToast(context, TypeMsg.msg,
                                        SettingsTextConstants.passwordChanged);
                                  } else {
                                    displaySettingsToast(context, TypeMsg.error,
                                        SettingsTextConstants.updatingError);
                                  }
                                });
                              },
                              title: SettingsTextConstants.edit,
                            ));
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ]),
                  child: const Center(
                    child: Text(
                      SettingsTextConstants.save,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
