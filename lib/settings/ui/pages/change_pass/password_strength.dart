import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/settings/ui/pages/change_pass/secure_bar.dart';

class PasswordStrength extends HookConsumerWidget {
  final TextEditingController newPassword;
  final Color textColor;
  final bool whiteBar;

  const PasswordStrength(
      {Key? key,
      required this.newPassword,
      this.whiteBar = false,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStrength =
        useState(SettingsTextConstants.passwordStrengthVeryWeak);
    return ValueListenableBuilder(
        valueListenable: newPassword,
        builder: (context, value, child) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "${SettingsTextConstants.passwordStrength} : ${currentStrength.value}",
                    style: TextStyle(fontSize: 18, color: textColor)),
              ),
              const SizedBox(
                height: 20,
              ),
              FlutterPasswordStrength(
                  password: newPassword.text,
                  backgroundColor: Colors.transparent,
                  radius: 10,
                  strengthColors: whiteBar
                      ? TweenSequence<Color>([
                          TweenSequenceItem(
                            weight: 1.0,
                            tween: Tween<Color>(
                              begin: Colors.white,
                              end: Colors.white,
                            ),
                          ),
                        ])
                      : TweenSequence<Color>([
                          TweenSequenceItem(
                            weight: 1.0,
                            tween: Tween<Color>(
                              begin: const Color(0xffd31336),
                              end: const Color(0xff880e65),
                            ),
                          ),
                          TweenSequenceItem(
                            weight: 1.0,
                            tween: Tween<Color>(
                              begin: const Color(0xff880e65),
                              end: const Color(0xff1c1840),
                            ),
                          ),
                          TweenSequenceItem(
                            weight: 1.0,
                            tween: Tween<Color>(
                              begin: const Color(0xff1c1840),
                              end: const Color(0xff3a5a81),
                            ),
                          ),
                          TweenSequenceItem(
                            weight: 1.0,
                            tween: Tween<Color>(
                              begin: const Color(0xff3a5a81),
                              end: const Color(0xff1791b1),
                            ),
                          ),
                        ]),
                  strengthCallback: (strength) {
                    if (strength < 0.2) {
                      currentStrength.value =
                          SettingsTextConstants.passwordStrengthVeryWeak;
                    } else if (strength < 0.4) {
                      currentStrength.value =
                          SettingsTextConstants.passwordStrengthWeak;
                    } else if (strength < 0.6) {
                      currentStrength.value =
                          SettingsTextConstants.passwordStrengthMedium;
                    } else if (strength < 0.8) {
                      currentStrength.value =
                          SettingsTextConstants.passwordStrengthStrong;
                    } else {
                      currentStrength.value =
                          SettingsTextConstants.passwordStrengthVeryStrong;
                    }
                  }),
            ],
          );
        });
  }
}
