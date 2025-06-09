import 'package:flutter/material.dart';
import 'package:myemapp/tools/constants.dart';

InputDecoration changePassInputDecoration({
  required String hintText,
  required ValueNotifier<bool> notifier,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
    hintStyle: TextStyle(fontSize: 18, color: Colors.grey.shade400),
    hintText: hintText,
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.gradient1),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade600),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.background2),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: ColorConstants.gradient2),
    ),
    errorStyle: const TextStyle(color: ColorConstants.background2),
    suffixIcon: IconButton(
      icon: Icon(
        notifier.value ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey.shade600,
      ),
      onPressed: () {
        notifier.value = !notifier.value;
      },
    ),
  );
}
