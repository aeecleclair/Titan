import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions;

  final Function() onYes;
  static const double padding = 20;
  static const double avatarRadius = 45;
  static const Color background = Color(0xfffafafa);

  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.onYes})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CustomDialogBox.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: CustomDialogBox.padding,
              top: CustomDialogBox.padding,
              right: CustomDialogBox.padding,
              bottom: CustomDialogBox.padding),
          margin: const EdgeInsets.only(top: CustomDialogBox.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: CustomDialogBox.background,
              borderRadius: BorderRadius.circular(CustomDialogBox.padding),
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
                widget.title,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey.shade800),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
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
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Non",
                            style: TextStyle(
                                fontSize: 18, color: Colors.red.shade700),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onYes();
                          },
                          child: Text(
                            "Oui",
                            style: TextStyle(
                                fontSize: 18, color: Colors.green.shade700),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
