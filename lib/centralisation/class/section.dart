import 'package:myecl/centralisation/class/module.dart';

class Section {
  Section({
    required this.name,
    required this.module_list,
    required this.expanded,
  });
  late final String name;
  late final List<Module> module_list;
  late final bool? expanded;

  Section.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    module_list = json['module_list'];
    expanded = json['expanded'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['module_list'] = module_list;
    if (expanded == null){
      data['expanded'] = true;
    } else {
      data['expanded'] = false ;
    };
    return data;
  }

  Section copyWith({
  String? name,
  List<Module>? module_list,
  bool? expanded

  })  =>
      Section(
      name: name ?? this.name,
      module_list: module_list ?? this.module_list,
      expanded: expanded ?? this.expanded
      );

  Section.empty() {
    name ='';
    module_list =[];
    expanded = true;
  }

  @override
  String toString() {
  return 'Section{name: $name, module_list: $module_list, expanded: $expanded}';
  }
}
