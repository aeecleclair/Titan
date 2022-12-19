import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myecl/tools/constants.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: ColorConstants.gradient1,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
        textTheme: GoogleFonts.notoSerifMalayalamTextTheme(),
        backgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: ColorConstants.gradient2,
            surface: Colors.grey.shade100,
            tertiary: const Color.fromARGB(255, 27, 29, 44),
            tertiaryContainer: Colors.grey.shade300));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: ColorConstants.gradient1,
        scaffoldBackgroundColor: const Color.fromARGB(255, 27, 29, 44),
        fontFamily: 'Montserrat',
        textTheme: GoogleFonts.notoSerifMalayalamTextTheme(),
        backgroundColor: Colors.grey.shade200,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: ColorConstants.gradient2,
            surface: Colors.grey.shade300,
            tertiary: Colors.grey.shade300,
            tertiaryContainer: Colors.grey.shade500));
  }
}
