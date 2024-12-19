import 'package:flutter/material.dart';

class FlappyBirdColors {
  bool isDarkTheme;
  FlappyBirdColors(this.isDarkTheme);
  Color? get sky => isDarkTheme ? Colors.indigo.shade900 : Colors.blue;
  Color? get land => isDarkTheme ? Colors.brown.shade900 : Colors.brown;
  Color? get text => isDarkTheme ? Colors.yellow : Colors.white;
}
