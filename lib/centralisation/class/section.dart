import 'package:myecl/centralisation/class/module.dart';

class Section {
  Section({
    required this.name,
    required this.moduleList,
    required this.expanded,
  });
  late final String name;
  late final List<Module> moduleList;
  late final bool? expanded;

  Section.fromJson(String name, List<Map<String, dynamic>> modulesJson) {
    name = name;
    moduleList = modulesJson.map((e) => Module.fromJson(e)) as List<Module>;
    expanded = true;
  }

  Section copyWith({String? name, List<Module>? moduleList, bool? expanded}) =>
      Section(
          name: name ?? this.name,
          moduleList: moduleList ?? this.moduleList,
          expanded: expanded ?? this.expanded);

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
