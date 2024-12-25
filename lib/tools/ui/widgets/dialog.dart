import 'package:flutter/material.dart';
import 'package:myecl/tools/constants.dart';

class CustomDialogBox extends StatelessWidget {
  final String title, descriptions;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? descriptionColor;
  final Color? yesColor;
  final Color? noColor;

  final Function() onYes;
  final Function()? onNo;

  static const double _padding = 20;
  static const double _avatarRadius = 45;

  const CustomDialogBox({
    super.key,
    required this.title,
    required this.descriptions,
    required this.onYes,
    this.onNo,
    this.titleColor,
    this.descriptionColor,
    this.yesColor,
    this.noColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).colorScheme.surface;
    final Color titleColor = Theme.of(context).colorScheme.primaryContainer;
    final Color descriptionColor = Theme.of(context).colorScheme.onSurface;
    final Color yesColor = Theme.of(context).colorScheme.primaryFixed;
    final Color noColor = Theme.of(context).colorScheme.onSurface;
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
              color: backgroundColor,
              borderRadius: BorderRadius.circular(CustomDialogBox._padding),
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
                          TextConstants.no,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: noColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (onNo == null) {
                            Navigator.of(context).pop();
                          }
                          await onYes();
                        },
                        child: Text(
                          TextConstants.yes,
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
