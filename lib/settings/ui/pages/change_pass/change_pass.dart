import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/change_pass/password_strength.dart';
import 'package:myecl/settings/ui/pages/change_pass/test_entry_style.dart';
import 'package:myecl/settings/ui/settings.dart';
import 'package:myecl/tools/ui/align_left_text.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ChangePassPage extends HookConsumerWidget {
  const ChangePassPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final oldPassword = useTextEditingController();
    final newPassword = useTextEditingController();
    final confirmPassword = useTextEditingController();
    final hideOldPass = useState(true);
    final hideNewPass = useState(true);
    final hideConfirmPass = useState(true);
    final userNotifier = ref.watch(asyncUserProvider.notifier);
    final user = ref.watch(userProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SettingsTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const AlignLeftText(SettingsTextConstants.changePassword,
                    fontSize: 20),
                const SizedBox(height: 30),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      cursorColor: const Color(0xFFfb6d10),
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
                const SizedBox(height: 30),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      cursorColor: const Color(0xFFfb6d10),
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
                const SizedBox(height: 30),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      cursorColor: const Color(0xFFfb6d10),
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
                const SizedBox(height: 40),
                PasswordStrength(newPassword: newPassword),
                const SizedBox(height: 60),
                ShrinkButton(
                  builder: (child) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 16, top: 12),
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
                        borderRadius: BorderRadius.circular(10)),
                    child: child,
                  ),
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      await showDialog(
                          context: context,
                          builder: (context) => CustomDialogBox(
                                descriptions:
                                    SettingsTextConstants.changingPassword,
                                onYes: () async {
                                  await tokenExpireWrapper(ref, () async {
                                    final value =
                                        await userNotifier.changePassword(
                                            oldPassword.text,
                                            newPassword.text,
                                            user);
                                    if (value) {
                                      QR.back();
                                      displayToastWithContext(
                                          TypeMsg.msg,
                                          SettingsTextConstants
                                              .passwordChanged);
                                    } else {
                                      displayToastWithContext(TypeMsg.error,
                                          SettingsTextConstants.updatingError);
                                    }
                                  });
                                },
                                title: SettingsTextConstants.edit,
                              ));
                    }
                  },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
