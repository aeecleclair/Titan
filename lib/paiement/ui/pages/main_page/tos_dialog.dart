import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';

class TOSDialogBox extends StatelessWidget {
  final String title, descriptions;
  static const Color titleColor = ColorConstants.onMain;
  static const Color descriptionColor = Colors.black;
  static const Color yesColor = Color.fromARGB(255, 9, 103, 103);
  static const Color noColor = ColorConstants.background2;

  final Function() onYes;
  final Function()? onNo;

  static const double _padding = 20;

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
    return Container(
      padding: const EdgeInsets.all(TOSDialogBox._padding),
      color: ColorConstants.background,
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
                    onNo == null ? Navigator.of(context).pop() : onNo?.call();
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
                SizedBox(height: 40),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
