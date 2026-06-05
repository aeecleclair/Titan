import 'package:flutter/material.dart';

class MyPaymentColors {
  bool isDarkTheme;
  MyPaymentColors(this.isDarkTheme);
  Color get secondaryGreen =>
      isDarkTheme ? Color(0xffb0d5e0) : Color(0xff204550);
  Color get gradient1 => isDarkTheme ? Color(0xff096767) : Color(0xff017f80);
  Color get gradient2 => isDarkTheme ? Color(0xff017f80) : Color(0xff096767);
  Color get gradient3 => isDarkTheme ? Color(0xff069293) : Color(0xff045454);
  static const Color onGradient = Colors.white;
  static const Color helloAssoBlue = Color(0xff4c40cf);
  static const Color errorText = Color(0xff5b0600);
}
