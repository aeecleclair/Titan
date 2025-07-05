import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/settings/ui/pages/change_pass/password_strength.dart';
import 'package:titan/settings/ui/pages/change_pass/test_entry_style.dart';
import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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
                AlignLeftText(
                  AppLocalizations.of(context)!.settingsChangePassword,
                  fontSize: 20,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    cursorColor: ColorConstants.gradient1,
                    decoration: changePassInputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.settingsOldPassword,
                      notifier: hideOldPass,
                    ),
                    controller: oldPassword,
                    obscureText: hideOldPass.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.settingsEmptyField;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    cursorColor: ColorConstants.gradient1,
                    decoration: changePassInputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.settingsNewPassword,
                      notifier: hideNewPass,
                    ),
                    controller: newPassword,
                    obscureText: hideNewPass.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.settingsEmptyField;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    cursorColor: ColorConstants.gradient1,
                    decoration: changePassInputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.settingsConfirmPassword,
                      notifier: hideConfirmPass,
                    ),
                    controller: confirmPassword,
                    obscureText: hideConfirmPass.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.settingsEmptyField;
                      } else if (value != newPassword.text) {
                        return AppLocalizations.of(
                          context,
                        )!.settingsPasswordsNotMatch;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                PasswordStrength(newPassword: newPassword),
                const SizedBox(height: 60),
                WaitingButton(
                  builder: (child) => AddEditButtonLayout(
                    colors: const [
                      ColorConstants.gradient1,
                      ColorConstants.gradient2,
                    ],
                    child: child,
                  ),
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      await showDialog(
                        context: context,
                        builder: (context) => CustomDialogBox(
                          descriptions: AppLocalizations.of(
                            context,
                          )!.settingsChangingPassword,
                          onYes: () async {
                            final passwordChangedMsg = AppLocalizations.of(
                              context,
                            )!.settingsPasswordChanged;
                            final passwordChangeErrorMsg = AppLocalizations.of(
                              context,
                            )!.settingsUpdatingError;
                            await tokenExpireWrapper(ref, () async {
                              final value = await userNotifier.changePassword(
                                oldPassword.text,
                                newPassword.text,
                                user,
                              );
                              if (value) {
                                QR.back();
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  passwordChangedMsg,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  passwordChangeErrorMsg,
                                );
                              }
                            });
                          },
                          title: AppLocalizations.of(context)!.settingsEdit,
                        ),
                      );
                    }
                  },
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.settingsSave,
                      style: const TextStyle(
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
