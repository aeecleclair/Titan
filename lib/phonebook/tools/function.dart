import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:tuple/tuple.dart';

String nameConstructor(Tuple2<RolesTags, List<bool>> data) {
  String name = '';
  for (int i = 0; i < data.item2.length; i++) {
    if (data.item2[i]) {
      name = "$name, ${data.item1.tags[i]}";
    }
  }
  if (name == "") {
    return "";
  }
  return name.substring(1, name.length);
}
