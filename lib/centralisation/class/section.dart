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

  Section.fromJson(k, v) {
    name = k;
    moduleList = List<Module>.from(v.map((e) => Module.fromJson(e)));
    expanded = true;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['module_list'] = moduleList;
    if (expanded == null) {
      data['expanded'] = true;
    } else {
      data['expanded'] = false;
    }
    return data;
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
