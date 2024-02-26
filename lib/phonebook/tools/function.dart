import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';
import 'package:tuple/tuple.dart';

String nameConstructor(Map<String, AsyncValue<List<bool>>> data) {
  String name = '';
  data.forEach((key, value) {
    value.maybeWhen(data: (d) {
      if (d[0]) {
        name += "$key,";
      }
    }, orElse: () {});
  });
  if (name == "") {
    return "";
  }
  return name.substring(1, name.length);
}
