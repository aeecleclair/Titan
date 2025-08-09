import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/login/ui/components/secure_bar.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/l10n/app_localizations.dart';

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
      AppLocalizations.of(context)!.settingsPasswordStrengthVeryWeak,
    );
    final useColor = textColor == Colors.black;
    return ValueListenableBuilder(
      valueListenable: newPassword,
      builder: (context, value, child) {
        return Column(
          children: [
            const SizedBox(height: 10),
            AlignLeftText(
              "${AppLocalizations.of(context)!.settingsPasswordStrength} : ${currentStrength.value}",
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
                  currentStrength.value = AppLocalizations.of(
                    context,
                  )!.settingsPasswordStrengthVeryWeak;
                } else if (strength < 0.4) {
                  currentStrength.value = AppLocalizations.of(
                    context,
                  )!.settingsPasswordStrengthWeak;
                } else if (strength < 0.6) {
                  currentStrength.value = AppLocalizations.of(
                    context,
                  )!.settingsPasswordStrengthMedium;
                } else if (strength < 0.8) {
                  currentStrength.value = AppLocalizations.of(
                    context,
                  )!.settingsPasswordStrengthStrong;
                } else {
                  currentStrength.value = AppLocalizations.of(
                    context,
                  )!.settingsPasswordStrengthVeryStrong;
                }
              },
            ),
          ],
        );
      },
    );
  }
}
