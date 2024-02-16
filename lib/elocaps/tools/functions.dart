import 'package:myecl/elocaps/class/caps_mode.dart';
import 'package:myecl/elocaps/tools/constants.dart';

String capsModeToString(CapsMode mode) {
  switch (mode) {
    case CapsMode.single:
      return ElocapsTextConstant.one_v_one;
    case CapsMode.cd:
      return ElocapsTextConstant.cd;
    case CapsMode.capacks:
      return ElocapsTextConstant.capacks;
    case CapsMode.semiCapacks:
      return ElocapsTextConstant.semi_capacks;
  }
}

CapsMode stringToCapsMode(String mode) {
  switch (mode) {
    case ElocapsTextConstant.one_v_one:
      return CapsMode.single;
    case ElocapsTextConstant.cd:
      return CapsMode.cd;
    case ElocapsTextConstant.capacks:
      return CapsMode.capacks;
    case ElocapsTextConstant.semi_capacks:
      return CapsMode.semiCapacks;
    default:
      return CapsMode.single;
  }
}
