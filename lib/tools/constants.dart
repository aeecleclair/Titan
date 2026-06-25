import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextConstants {
  static const String admin = 'Admin';
  static const String error = "Une erreur est survenue";
  static const String noValue = "Veuillez entrer une valeur";
  static const String invalidNumber = "Veuillez entrer un nombre";
  static const String noDateError = "Veuillez entrer une date";
  static const String imageSizeTooBig =
      "La taille de l'image ne doit pas dépasser 4 Mio";
  static const String imageError = "Erreur lors de l'ajout de l'image";
  static const String yes = "Oui";
  static const String no = "Non";
}

const String unableToOpen = 'Impossible d\'ouvrir le lien';

const int maxHyperionFileSize = 4194304;

// Old colors: don't forget to nuke that class when there will be no more references to it
class ColorConstants {
  static const Color gradient1 = Color(0xFFfb6d10);
  static const Color gradient2 = Color(0xffeb3e1b);
  static const Color error = Color(0xFFC91717);
  static const Color background2 = Color(0xFF222643);
  static const Color deactivated1 = Color(0xFF9E9E9E);
  static const Color deactivated2 = Color(0xFFC0C0C0);
}

/// ## Semantics of the Colors
///
/// ### Main colors
///
/// `primary` is the ultimate background, hence the most prominent onscreen,
/// the theme is named after the "brightness" of `primary`.
///
/// There are 3 main colors, they strongly contrast with each other:
/// * `secondary` is the opposite of `primary`;
/// * `primaryContainer` is a true color (not some grayscale), a vivid one, to emphasize.
///
/// `secondary` and `primaryContainer` are for surfaces displayed on top of `primary`.
///
/// `surface` is identical to `primary`, in case a surface of this color is needed.
///
/// ### Miscellaneous colors
///
/// * `tertiary` is a blend of `primary` and `secondary`,
/// and in practice is it the same for both themes (and is seldom used, so far).
/// * `error` is red in any case.
/// * `primaryContainer` is defined to be close to `primarySwatch`,
/// which is outside of `colorScheme` and never written in code,
/// it is just to have a default non-grayscale color.
/// * However `shadowColor` is written in code altough defined outside of `colorScheme`,
/// it is a translucent color, closer to `primary`, meant to be the default for shadows.
///
/// ### `on-` prefix
///
/// * Without the `on-` prefix, it is for surfaces (buttons, cards).
/// * With `on-`, it is for things with no "thickness" (texts, icons, borders),
/// such that nothing could be displayed on top of them.
///
/// `onSomeColor` should be very legible on `someColor`,
/// so `onPrimaryContainer` and `onError` should be chosen carefully
/// since they do not have a natural opposite.
///
/// Meanwhile, the primary-secondary duality is still there with `on-`, thus:
/// * `onSurface` = `onPrimary` := `secondary`
/// * `onSecondary` := `primary`
/// * etc.
///
/// ### `-Fixed` suffix
///
/// Likewise, the `-Fixed` suffix is for a less strong variant,
/// needed in some contexts (a discrete shadow, a minimal yet visible contrast),
/// hence `primaryFixed` and `secondaryFixed` are opposite.
///
/// `secondaryContainer` is to be understood as "primaryContainerFixed"
/// as it is actually a variant of `primaryContainer`,
/// slightly farther from `primary` and used mostly for gradients:
/// `primaryContainer` and `primaryFixed` are formerly known
/// as "gradient1" and "gradient2" here on Titan.
///
/// ### LIST OF INCONSISTENCIES to fix (in that order)
///
/// 1. Replace most `secondaryFixed` with `tertiary` (don't remember why, though)
/// 1. Swap `primaryFixed` and `secondaryContainer`
/// 1. Swap the `-Fixed`
///
class ThemeConstants {
  // for textTheme
  BuildContext context;
  ThemeConstants(this.context);

  ThemeData get lightTheme => ThemeData(
    brightness: .light,
    primarySwatch: Colors.orange,
    shadowColor: Colors.grey.withValues(alpha: 0.3),
    colorScheme: const ColorScheme(
      brightness: .light,
      primary: Colors.white, //Color(0xffFEF7FF),
      onPrimary: Colors.black,
      secondary: Colors.black,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      primaryContainer: Color(0xfffb6d10),
      primaryFixed: Color(0xffeb3e1b),
      onPrimaryContainer: Colors.white,
      secondaryFixed: Color(0xFFDDDDDD),
      secondaryContainer: Color(0xFF222222),
      tertiary: Colors.grey,
      error: Colors.red,
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(
        context,
      ).textTheme.apply(bodyColor: Colors.black, displayColor: Colors.black),
    ),
  );
  ThemeData get darkTheme => ThemeData(
    brightness: .dark,
    primarySwatch: Colors.orange,
    shadowColor: Colors.grey.withValues(alpha: 0.7),
    colorScheme: const ColorScheme(
      brightness: .dark,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      surface: Colors.black,
      onSurface: Colors.white,
      primaryContainer: Color(0xffeb3e1b),
      primaryFixed: Color(0xfffb6d10),
      onPrimaryContainer: Colors.white,
      secondaryFixed: Color(0xFF222222),
      secondaryContainer: Color(0xFFDDDDDD),
      tertiary: Colors.grey,
      error: Colors.red,
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(
        context,
      ).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
    ),
  );
}

// Reference: Flutter's default theme
// ignore: unused_element
ThemeData _ = ThemeData(
  brightness: .light,
  shadowColor: Color(0xff000000),
  colorScheme: const ColorScheme(
    brightness: .light,
    primary: Color(0xff6750a4),
    onPrimary: Color(0xffffffff),
    secondary: Color(0xff625b71),
    onSecondary: Color(0xffffffff),
    surface: Color(0xfffef7ff),
    onSurface: Color(0xff1d1b20),
    primaryContainer: Color(0xffeaddff),
    primaryFixed: Color(0xffeaddff),
    onPrimaryContainer: Color(0xff4f378b),
    secondaryFixed: Color(0xffe8def8),
    secondaryContainer: Color(0xffe8def8),
    tertiary: Color(0xff7d5260),
    error: Color(0xffb3261e),
    onError: Color(0xffffffff),
  ),
);
