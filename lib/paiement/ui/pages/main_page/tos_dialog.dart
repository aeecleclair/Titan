import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class TOSDialogBox extends StatelessWidget {
  final String title, descriptions;
  static const Color titleColor = Color.fromARGB(255, 4, 84, 84);
  static const Color descriptionColor = Colors.black;
  static const Color yesColor = Color.fromARGB(255, 9, 103, 103);
  static const Color noColor = ColorConstants.background2;

  final Function() onYes;
  final Function()? onNo;

  static const double _padding = 20;
  static const double _avatarRadius = 45;

  static const Color background = Color(0xfffafafa);
  const TOSDialogBox({
    super.key,
    required this.title,
    required this.descriptions,
    required this.onYes,
    this.onNo,
  });

  @override
  Widget build(BuildContext context) {
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
              color: TOSDialogBox.background,
              borderRadius: BorderRadius.circular(TOSDialogBox._padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
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
                  style: const TextStyle(
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
                          AppLocalizations.of(context)!.paiementDecline,
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
                          AppLocalizations.of(context)!.paiementAccept,
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
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
