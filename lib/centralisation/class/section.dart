import 'package:titan/centralisation/class/module.dart';

class Section {
  Section({
    required this.name,
    required this.moduleList,
    required this.expanded,
  });
  late final String name;
  late final List<Module> moduleList;
  late final bool? expanded;

  Section.fromJson(String k, List<dynamic> v) {
    name = k;
    moduleList = List<Module>.from(
      v.map((e) => Module.fromJson(e as Map<String, dynamic>)),
    );
    expanded = true;
  }

  Section copyWith({String? name, List<Module>? moduleList, bool? expanded}) =>
      Section(
        name: name ?? this.name,
        moduleList: moduleList ?? this.moduleList,
        expanded: expanded ?? this.expanded,
      );

  Section.empty() {
    name = '';
    moduleList = [];
    expanded = true;
  }

  @override
  String toString() {
    return 'Section{name: $name, module_list: $moduleList, expanded: $expanded}';
  }
}
