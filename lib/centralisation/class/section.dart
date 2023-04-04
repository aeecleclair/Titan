class Module {
  Module({
    required this.name,
    required this.module_list,
    this.expanded,
  });
  late final String name;
  late final List module_list;
  late final bool? expanded;

  Module.fromJson(Map<String, dynamic> json) {
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
      data['expanded'] = expanded ;
    };
    return data;
  }

  Module copyWith({
    String? name,
    List? module_list,
    bool? expanded,

  })  =>
      Module(
        name: name ?? this.name,
        module_list: module_list ?? this.module_list,
        expanded: expanded,
      );

  Module.empty() {
    name ='';
    module_list=[];
    expanded=true;
  }

  @override
  String toString() {
    return 'Section{name: $name, module_list: $module_list, expanded: $expanded}';
  }
}
