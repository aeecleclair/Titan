import 'package:flutter/material.dart';

//static const Color background = Colors.blue;

/*
class FlappyBirdLightTheme {
  static Color sky = Colors.blue;
  static Color land = Colors.brown;
  static Color text = Colors.white;
}

class FlappyBirdDarkTheme {
  static Color sky = Colors.indigo.shade900;
  static Color land = Colors.brown.shade900;
  static Color text = Colors.yellow;
}
*/

class FlappyBirdColors {
  bool isDarkTheme;
  FlappyBirdColors(this.isDarkTheme);
  Color? get sky => isDarkTheme ? Colors.indigo.shade900 : Colors.blue;
  Color? get land => isDarkTheme ? Colors.brown.shade900 : Colors.brown;
  Color? get text => isDarkTheme ? Colors.yellow : Colors.white;
}
