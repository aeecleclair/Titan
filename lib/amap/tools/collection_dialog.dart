import 'package:flutter/material.dart';
import 'package:myecl/amap/providers/collection_slot_provider.dart';
import 'package:myecl/amap/tools/constants.dart';

class CollectionDialogBox extends StatefulWidget {
  final String title, descriptions;

  final Function(CollectionSlot) onClick;

  static const double _padding = 20;
  static const double _avatarRadius = 45;

  static const Color background = Color(0xfffafafa);

  const CollectionDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.onClick})
      : super(key: key);

  @override
  _CollectionDialogBoxState createState() => _CollectionDialogBoxState();
}

class _CollectionDialogBoxState extends State<CollectionDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CollectionDialogBox._padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  String getText(CollectionSlot cs) {
    return cs.toString().split(".")[1];
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(CollectionDialogBox._padding),
          margin: const EdgeInsets.only(top: CollectionDialogBox._avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: CollectionDialogBox.background,
              borderRadius: BorderRadius.circular(CollectionDialogBox._padding),
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
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: AMAPColorConstants.textDark),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(
                  fontSize: 14,
                  color: AMAPColorConstants.enabled,
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
                            widget.onClick(CollectionSlot.midi);
                          },
                          child: Text(
                            getText(CollectionSlot.midi),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AMAPColorConstants.greenGradient2),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onClick(CollectionSlot.soir);
                          },
                          child: Text(
                            getText(CollectionSlot.soir),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AMAPColorConstants.greenGradient2),
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
