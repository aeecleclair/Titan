import 'package:myecl/vote/class/pretendance.dart';

ListType stringToListType(String type) {
  switch (type) {
    case 'Serio':
      return ListType.serio;
    case 'Pipo':
      return ListType.pipo;
    default:
      return ListType.pipo;
  }
}
