import 'package:myecl/centralisation/class/module.dart';

class Section {
  String name;
  List<Module> modules;

  Section({required this.name, required this.modules});

  factory Section.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final modulesJson = json['modules'] as List<dynamic>;
    final modules = modulesJson.map((moduleJson) => Module.fromJson(moduleJson)).toList();
    return Section(name: name, modules: modules);
  }
}