import 'package:myecl/elocaps/class/caps_mode.dart';

String capsModeToString(CapsMode mode) {
  switch (mode) {
    case CapsMode.single:
      return 'single';
    case CapsMode.cd:
      return 'cd';
    case CapsMode.capacks:
      return 'capacks';
    case CapsMode.semiCapacks:
      return 'semi_capacks';
  }
}

CapsMode stringToCapsMode(String mode) {
  switch (mode) {
    case 'single':
      return CapsMode.single;
    case 'cd':
      return CapsMode.cd;
    case 'capacks':
      return CapsMode.capacks;
    case 'semi_capacks':
      return CapsMode.semiCapacks;
    default:
      return CapsMode.single;
  }
}
