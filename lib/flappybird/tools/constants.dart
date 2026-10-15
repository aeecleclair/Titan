import 'package:flutter/material.dart';

class FlappyBirdColors {
  bool isDarkTheme;
  FlappyBirdColors(this.isDarkTheme);
  Color get sky => isDarkTheme ? const Color(0xff040348) : Colors.blue;
  Color get land => isDarkTheme ? const Color(0xff402000) : Colors.brown;
  Color get text => isDarkTheme ? Colors.amber : Colors.white;
}
