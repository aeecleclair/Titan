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

const String previousEmailRegex =
    r'^[\w\-.]*@((ecl\d{2})|(alternance\d{4})|(master)|(auditeur)).ec-lyon.fr$';

const String previousStaffEmailRegex = r'^[\w\-.]*@ec-lyon.fr$';

const String studentRegex = r'^[\w\-.]*@etu(-enise)?.ec-lyon.fr$';

const String unableToOpen = 'Impossible d\'ouvrir le lien';

const int maxHyperionFileSize = 4194304;

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
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        shadowColor: Colors.grey.withValues(alpha: 0.3),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
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
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
        ),
      );
  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        shadowColor: Colors.grey.withValues(alpha: 0.7),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          surface: Colors.black,
          onSurface: Colors.white,
          primaryContainer: Color(0xff6d10fb),
          primaryFixed: Color(0xff9c05eb),
          onPrimaryContainer: Colors.black,
          secondaryFixed: Color(0xFF222222),
          secondaryContainer: Color(0xFFDDDDDD),
          error: Colors.red,
          onError: Colors.white,
          tertiary: Colors.grey,
        ),
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      );
}
