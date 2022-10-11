import 'package:flutter/material.dart';
import 'package:myecl/settings/tools/constants.dart';

InputDecoration changePassInputDecoration(
    {required String hintText, required ValueNotifier<bool> notifier}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
      hintStyle: TextStyle(
        fontSize: 18,
        color: Colors.grey.shade400,
      ),
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFfb6d10))),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 124, 124, 124)),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: SettingsColorConstants.background2),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide:
            BorderSide(width: 2.0, color: SettingsColorConstants.gradient2),
      ),
      errorStyle: const TextStyle(color: SettingsColorConstants.background2),
      suffixIcon: IconButton(
        icon: Icon(notifier.value ? Icons.visibility : Icons.visibility_off,
            color: const Color.fromARGB(255, 124, 124, 124)),
        onPressed: () {
          notifier.value = !notifier.value;
        },
      ));
}
