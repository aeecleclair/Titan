import 'package:flutter/material.dart';
import 'package:myemapp/tools/constants.dart';

InputDecoration signInRegisterInputDecoration({
  required String hintText,
  required bool isSignIn,
  ValueNotifier<bool>? notifier,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
    hintStyle: TextStyle(
      fontSize: 18,
      color: isSignIn ? Colors.black : Colors.white,
    ),
    hintText: hintText,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: isSignIn ? Colors.grey.shade600 : Colors.white,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: isSignIn ? Colors.grey.shade600 : Colors.white,
      ),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorConstants.gradient2),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: ColorConstants.gradient2),
    ),
    errorStyle: TextStyle(
      color: isSignIn ? ColorConstants.gradient2 : Colors.white,
    ),
    suffixIcon: notifier == null
        ? null
        : IconButton(
            icon: Icon(
              notifier.value ? Icons.visibility : Icons.visibility_off,
              color: isSignIn ? Colors.grey.shade600 : Colors.white,
            ),
            onPressed: () {
              notifier.value = !notifier.value;
            },
          ),
  );
}
