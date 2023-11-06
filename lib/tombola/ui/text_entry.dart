import 'package:flutter/material.dart';
import 'package:myecl/tombola/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String? suffixText;
  final bool disabled;

  const TextEntry(
      {Key? key,
      required this.validator,
      required this.textEditingController,
      required this.keyboardType,
      this.suffixText,
      this.disabled = false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      child: TextFormField(
        validator: validator,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        controller: textEditingController,
        cursorColor: TombolaColorConstants.gradient2,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          suffixText: suffixText,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: TombolaColorConstants.gradient2)),
          errorBorder: const UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 201, 23, 23))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: TombolaColorConstants.textDark,
          )),
        ),
        readOnly: disabled,
      ),
    );
  }
}
