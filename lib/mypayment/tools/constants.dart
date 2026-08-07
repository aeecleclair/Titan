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
  Color get redGradient1 => isDarkTheme ? Color(0xFF590512) : Color(0xFF9E131F);
  Color get redGradient2 => isDarkTheme ? Color(0xFF9E131F) : Color(0xFF590512);
  Color get backgroundGradient1 =>
      isDarkTheme ? Color(0xff001d1d) : Color(0xff064b4b);
  Color get backgroundGradient2 =>
      isDarkTheme ? Color(0xff064b4b) : Color(0xff001d1d);
  Color get backgroundGradient3 =>
      isDarkTheme ? Color(0xff002424) : Color(0xff004444);
  Color get secondaryGradient1 =>
      isDarkTheme ? Color(0xffff991a) : Color(0xffff7707);
  Color get secondaryGradient2 =>
      isDarkTheme ? Color(0xfff98801) : Color(0xffe66700);
  static const scannerGreenGradient1 = Color(0xff79a400);
  static const scannerGreenGradient2 = Color(0xff387200);
  static const scannerRedGradient1 = Color(0xffa40000);
  static const scannerRedGradient2 = Color(0xff720000);
}
