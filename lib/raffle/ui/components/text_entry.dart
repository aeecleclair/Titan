import 'package:flutter/material.dart';
import 'package:myecl/raffle/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final Function validator;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String? suffixText;

  const TextEntry(
      {Key? key,
      required this.validator,
      required this.textEditingController,
      required this.keyboardType,
      this.suffixText
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      child: TextFormField(
        validator: ((value) {
          return validator(value);
        }),
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        controller: textEditingController,
        cursorColor: RaffleColorConstants.gradient2,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          suffixText: suffixText,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: RaffleColorConstants.gradient2)),
          errorBorder: const UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 201, 23, 23))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: RaffleColorConstants.textDark,
          )),
        ),
      ),
    );
  }
}
