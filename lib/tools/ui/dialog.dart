import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';

class CustomDialogBox extends StatelessWidget {
  final String title, descriptions;
  final Color titleColor = ColorConstants.gradient1;
  final Color descriptionColor = Colors.black;
  final Color yesColor = ColorConstants.gradient2;
  final Color noColor = ColorConstants.background2;

  final Function() onYes;
  final Function()? onNo;

  static const double _padding = 20;
  static const double _avatarRadius = 45;

  static const Color background = Color(0xfffafafa);
  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.onYes,
      this.onNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomDialogBox._padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(CustomDialogBox._padding),
              margin: const EdgeInsets.only(top: CustomDialogBox._avatarRadius),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: CustomDialogBox.background,
                  borderRadius: BorderRadius.circular(CustomDialogBox._padding),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade700,
                        offset: const Offset(0, 5),
                        blurRadius: 5),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: titleColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    descriptions,
                    style: TextStyle(
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
                              child: Text(
                                "Non",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: noColor),
                              )),
                          TextButton(
                              onPressed: () async {
                                if (onNo == null) {
                                  Navigator.of(context).pop();
                                }
                                await onYes();
                              },
                              child: Text(
                                "Oui",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: yesColor),
                              )),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
