import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myemapp/settings/tools/constants.dart';
import 'package:myemapp/settings/ui/pages/change_pass/secure_bar.dart';
import 'package:myemapp/tools/ui/widgets/align_left_text.dart';

class PasswordStrength extends HookConsumerWidget {
  final TextEditingController newPassword;
  final Color textColor;
  final Color color0 = const Color(0xffd31336);
  final Color color1 = const Color(0xff880e65);
  final Color color2 = const Color(0xff1c1840);
  final Color color3 = const Color(0xff3a5a81);
  final Color color4 = const Color(0xff1791b1);

  const PasswordStrength({
    super.key,
    required this.newPassword,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStrength = useState(
      SettingsTextConstants.passwordStrengthVeryWeak,
    );
    final useColor = textColor == Colors.black;
    return ValueListenableBuilder(
      valueListenable: newPassword,
      builder: (context, value, child) {
        return Column(
          children: [
            const SizedBox(height: 10),
            AlignLeftText(
              "${SettingsTextConstants.passwordStrength} : ${currentStrength.value}",
              color: textColor,
            ),
            const SizedBox(height: 10),
            FlutterPasswordStrength(
              password: newPassword.text,
              backgroundColor: Colors.transparent,
              radius: 10,
              strengthColors: TweenSequence<Color?>([
                TweenSequenceItem(
                  weight: 1.0,
                  tween: Tween<Color>(
                    begin: useColor ? color0 : Colors.white,
                    end: useColor ? color1 : Colors.white,
                  ),
                ),
                TweenSequenceItem(
                  weight: 1.0,
                  tween: Tween<Color>(
                    begin: useColor ? color1 : Colors.white,
                    end: useColor ? color2 : Colors.white,
                  ),
                ),
                TweenSequenceItem(
                  weight: 1.0,
                  tween: Tween<Color>(
                    begin: useColor ? color2 : Colors.white,
                    end: useColor ? color3 : Colors.white,
                  ),
                ),
                TweenSequenceItem(
                  weight: 1.0,
                  tween: Tween<Color>(
                    begin: useColor ? color3 : Colors.white,
                    end: useColor ? color4 : Colors.white,
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
              },
            ),
          ],
        );
      },
    );
  }
}
