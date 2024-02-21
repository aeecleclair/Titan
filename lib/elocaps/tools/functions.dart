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
