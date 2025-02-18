import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';

class CGUDialogBox extends StatelessWidget {
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
  const CGUDialogBox({
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
        borderRadius: BorderRadius.circular(CGUDialogBox._padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(CGUDialogBox._padding),
            margin: const EdgeInsets.only(top: CGUDialogBox._avatarRadius),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: CGUDialogBox.background,
              borderRadius: BorderRadius.circular(CGUDialogBox._padding),
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
                const SizedBox(
                  height: 15,
                ),
                Text(
                  descriptions,
                  style: const TextStyle(
                    fontSize: 14,
                    color: descriptionColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 22,
                ),
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
                        child: const Text(
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
                        child: const Text(
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
