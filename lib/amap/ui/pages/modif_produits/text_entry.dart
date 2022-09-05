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
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: AMAPColorConstants.enabled)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 201, 23, 23))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: AMAPColorConstants.greenGradient2,
              )),
        ),
      ),
    );
  }
}
