import 'package:myecl/tools/functions.dart';

class Todo {
  final String id;
  final String name;
  final DateTime? deadline;
  final bool done;
  final DateTime creation;

  Todo(
      {required this.id,
      required this.name,
      required this.deadline,
      required this.done,
      required this.creation}
      );
  
  Todo.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      deadline =
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      done = json['done'],
      creation = DateTime.parse(json['creation']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'deadline': deadline != null ? processDateToAPIWitoutHour(deadline!) : null,
        'done': done,
        'creation': processDateToAPIWitoutHour(creation),
      };
  
  Todo.empty()
      : id = "",
        name = "",
        deadline = null,
        done = false,
        creation = DateTime.now();
  
  Todo copyWith(
          {String? id,
          String? name,
          DateTime? deadline,
          bool? done,
          DateTime? creation}) =>
      Todo(
        id: id ?? this.id,
        name: name ?? this.name,
        deadline: deadline ?? this.deadline,
        done: done ?? this.done,
        creation: creation ?? this.creation,
        );
  
  @override
  String toString() {
    return 'Todo{id: $id, name: $name, deadline: $deadline, done: $done, creation: $creation}';
  }
}