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
    for(var i in json){
      var key = i;
      var val = json[i];
      for(var j in val){
        var sub_key = j;
        name=sub_key;
        var sub_val = val[j];
        Module.fromJson(sub_val);
      }
    }
    expanded=true;
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
