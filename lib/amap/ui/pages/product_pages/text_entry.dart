import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';

class TextEntry extends StatelessWidget {
  final Function validator, onChanged;

  final TextEditingController textEditingController;

  final TextInputType keyboardType;

  final bool enabled;

  const TextEntry(
      {Key? key,
      required this.validator,
      required this.textEditingController,
      required this.keyboardType,
      required this.onChanged,
      required this.enabled})
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
        onChanged: (_) {
          onChanged(_);
        },
        enabled: enabled,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        controller: textEditingController,
        cursorColor: AMAPColorConstants.enabled,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AMAPColorConstants.enabled)),
          errorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 201, 23, 23))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: AMAPColorConstants.greenGradient2,
          )),
        ),
      ),
    );
  }
}
