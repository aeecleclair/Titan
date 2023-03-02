import 'package:flutter/material.dart';
import 'package:myecl/tombola/tools/constants.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.text, required this.size})
      : super(key: key);
  final String text;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
        ),
        Container(
          padding: EdgeInsets.only(left: size/2.1,right:size/2.1,bottom:size/10),
          margin:
              const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(125, 3, 2, 69),
                  spreadRadius: 0,
                  blurRadius: 8,
                  blurStyle: BlurStyle.outer,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  TombolaColorConstants.lightGradientBlueButton,
                  TombolaColorConstants.darkGradientBlueButton,
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(size))),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 1.5 * size,
                color: TombolaColorConstants.writtenWhite),
          ),
        )
      ],
    );
  }
}
