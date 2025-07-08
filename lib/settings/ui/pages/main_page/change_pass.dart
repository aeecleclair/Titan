import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/settings/ui/pages/main_page/password_strength.dart';
import 'package:titan/settings/ui/pages/main_page/test_entry_style.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
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

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextEntry(
                controller: oldPassword,
                // obscureText: hideOldPass.value,
                label: 'Ancien mot de passe',
                maxLines: 1,
                suffixIcon: IconButton(
                  icon: Icon(
                    hideOldPass.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {
                    hideOldPass.value = !hideOldPass.value;
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextEntry(
                controller: newPassword,
                obscureText: hideNewPass.value,
                label: 'Nouveau mot de passe',
                maxLines: 1,
                suffixIcon: IconButton(
                  icon: Icon(
                    hideNewPass.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {
                    hideNewPass.value = !hideNewPass.value;
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextEntry(
                controller: confirmPassword,
                obscureText: hideConfirmPass.value,
                label: 'Confirmer le mot de passe',
                maxLines: 1,
                suffixIcon: IconButton(
                  icon: Icon(
                    hideConfirmPass.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {
                    hideConfirmPass.value = !hideConfirmPass.value;
                  },
                ),
              ),
              const SizedBox(height: 20),
              PasswordStrength(newPassword: newPassword),
              const SizedBox(height: 20),
              Button(
                text: "Enregistrer",
                onPressed: () async {
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
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.settingsSave,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
