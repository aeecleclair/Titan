import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/providers/theme_provider.dart';

class Consts {
  Consts._();

  static const double padding = 20.0;
  static const double avatarRadius = 50.0;
}

class DeviceDialogBox extends ConsumerWidget {
  final String title, descriptions;
  final String? buttonText;
  final Function() onClick;

  const DeviceDialogBox({
    super.key,
    required this.title,
    required this.descriptions,
    required this.onClick,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        // to darken the page behind the dialog, independently on the theme, cf. CustomDialogBox
        color: Colors.black54,
        child: GestureDetector(
          onTap: () {},
          child: Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: .all(Radius.circular(20.0)),
            ),
            elevation: 0.0,
            insetPadding: const .all(20.0),
            backgroundColor: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const .only(
                    top: Consts.avatarRadius + Consts.padding,
                    bottom: Consts.padding,
                    left: Consts.padding,
                    right: Consts.padding,
                  ),
                  margin: const .only(top: Consts.avatarRadius),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.rectangle,
                    borderRadius: .circular(Consts.padding),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: .min, // To make the card compact
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: .w700,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        descriptions,
                        textAlign: .center,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          if (buttonText != null)
                            GestureDetector(
                              onTap: () {
                                onClick.call();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width -
                                    4 * Consts.padding,
                                padding: const .symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: .circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                      Theme.of(context).colorScheme.secondary,
                                    ],
                                    begin: .topLeft,
                                    end: .bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      blurRadius: 2.0,
                                      offset: const Offset(1.0, 2.0),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    buttonText!,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: Consts.padding,
                  right: Consts.padding,
                  child: Container(
                    width: Consts.avatarRadius * 2,
                    height: Consts.avatarRadius * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          MyPaymentColors(isDarkTheme).redGradient1,
                          MyPaymentColors(isDarkTheme).redGradient2,
                        ],
                        begin: .topLeft,
                        end: .bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: MyPaymentColors(
                            isDarkTheme,
                          ).redGradient2.withValues(alpha: 0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: HeroIcon(
                        .exclamationCircle,
                        size: 60,
                        color: MyPaymentColors.onGradient,
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
