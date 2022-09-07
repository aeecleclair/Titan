import 'package:flutter/material.dart';
import 'package:myecl/login/tools/constants.dart';

InputDecoration signInRegisterInputDecoration(
    {required String hintText,
    required bool isSignIn,
    ValueNotifier<bool>? notifier}) {
  if (notifier != null) {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
        hintStyle: TextStyle(
          fontSize: 18,
          color: isSignIn ? Colors.black : Colors.white,
        ),
        hintText: hintText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: isSignIn
                  ? const Color.fromARGB(255, 124, 124, 124)
                  : Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: isSignIn
                  ? const Color.fromARGB(255, 124, 124, 124)
                  : Colors.white),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: LoginColorConstants.gradient2),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide:
              BorderSide(width: 2.0, color: LoginColorConstants.gradient2),
        ),
        errorStyle: TextStyle(
            color: isSignIn ? LoginColorConstants.gradient2 : Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            notifier.value ? Icons.visibility : Icons.visibility_off,
            color: isSignIn ? const Color.fromARGB(255, 124, 124, 124) : Colors.white,
          ),
          onPressed: () {
            notifier.value = !notifier.value;
          },
        ));
  } else {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
        hintStyle: TextStyle(
          fontSize: 18,
          color: isSignIn ? Colors.black : Colors.white,
        ),
        hintText: hintText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: isSignIn
                  ? const Color.fromARGB(255, 124, 124, 124)
                  : Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: isSignIn
                  ? const Color.fromARGB(255, 124, 124, 124)
                  : Colors.white),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: LoginColorConstants.gradient2),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide:
              BorderSide(width: 2.0, color: LoginColorConstants.gradient2),
        ),
        errorStyle: TextStyle(
            color: isSignIn ? LoginColorConstants.gradient2 : Colors.white));
  }
}
