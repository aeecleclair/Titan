import 'dart:ui';
import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/tools/constants.dart';

String apiCapsModeToString(CapsMode mode) {
  switch (mode) {
    case CapsMode.single:
      return ElocapsTextConstant.apiOneVOne;
    case CapsMode.cd:
      return ElocapsTextConstant.apiCd;
    case CapsMode.capacks:
      return ElocapsTextConstant.apiCapacks;
    case CapsMode.semiCapacks:
      return ElocapsTextConstant.apiSemiCapacks;
  }
}

String capsModeToString(CapsMode mode) {
  switch (mode) {
    case CapsMode.single:
      return ElocapsTextConstant.oneVOne;
    case CapsMode.cd:
      return ElocapsTextConstant.cd;
    case CapsMode.capacks:
      return ElocapsTextConstant.capacks;
    case CapsMode.semiCapacks:
      return ElocapsTextConstant.semiCapacks;
  }
}

CapsMode stringToCapsMode(String mode) {
  switch (mode) {
    case ElocapsTextConstant.oneVOne:
      return CapsMode.single;
    case ElocapsTextConstant.cd:
      return CapsMode.cd;
    case ElocapsTextConstant.capacks:
      return CapsMode.capacks;
    case ElocapsTextConstant.semiCapacks:
      return CapsMode.semiCapacks;
    default:
      return CapsMode.single;
  }
}

String scoreToWinOrLose(int score) {
  if (score > 0) {
    return ElocapsTextConstant.victory;
  } else if (score == 0) {
    return ElocapsTextConstant.draw;
  }
  return ElocapsTextConstant.defeat;
}

List<Color> scoreToColor(int score, bool gameConfirmed, bool gameCancelled) {
  if (gameConfirmed) {
    if (score > 0) {
      return [
        const Color.fromARGB(255, 27, 72, 30),
        const Color.fromARGB(255, 95, 230, 65)
      ];
    } else if (score == 0) {
      return [
        const Color.fromARGB(255, 81, 86, 15),
        const Color.fromARGB(255, 227, 240, 39)
      ];
    }
    return [
      const Color.fromARGB(255, 115, 3, 3),
      const Color.fromARGB(255, 231, 84, 31)
    ];
  } else if (gameCancelled) {
    return [
      const Color.fromARGB(255, 32, 31, 31),
      const Color.fromARGB(255, 201, 197, 196)
    ];
  }
  return [
    const Color.fromARGB(255, 30, 17, 75),
    const Color.fromARGB(255, 59, 189, 241)
  ];
}
