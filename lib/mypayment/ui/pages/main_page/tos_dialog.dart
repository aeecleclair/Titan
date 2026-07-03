import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/tools/constants.dart';
import 'package:titan/tools/providers/theme_provider.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class TOSDialogBox extends ConsumerWidget {
  final String title, descriptions;

  final Function() onYes;
  final Function()? onNo;

  static const double _padding = 20;
  static const double _avatarRadius = 45;

  const TOSDialogBox({
    super.key,
    required this.title,
    required this.descriptions,
    required this.onYes,
    this.onNo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    final titleColor = MyPaymentColors(isDarkTheme).gradient3;
    final yesColor = MyPaymentColors(isDarkTheme).gradient2;
    final noColor = Theme.of(context).colorScheme.secondaryContainer;
    final background = Theme.of(context).colorScheme.surface;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TOSDialogBox._padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(TOSDialogBox._padding),
            margin: const EdgeInsets.only(top: TOSDialogBox._avatarRadius),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: background,
              borderRadius: BorderRadius.circular(TOSDialogBox._padding),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 15),
                MarkdownBody(
                  data: descriptions,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet(
                    h2Padding: const EdgeInsets.only(top: 20.0),
                    textAlign: WrapAlignment.spaceAround,
                  ),
                ),
                const SizedBox(height: 22),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          onNo == null
                              ? Navigator.of(context).pop()
                              : onNo?.call();
                        },
                        child: Text(
                          "Refuser",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: noColor,
                          ),
                        ),
                      ),
                      WaitingButton(
                        onTap: () async {
                          if (onNo == null) {
                            Navigator.of(context).pop();
                          }
                          await onYes();
                        },
                        builder: (child) => child,
                        child: Text(
                          "Accepter",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: yesColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
