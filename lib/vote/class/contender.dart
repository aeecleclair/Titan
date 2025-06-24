import 'package:titan/vote/class/members.dart';
import 'package:titan/vote/class/section.dart';
import 'package:titan/vote/tools/functions.dart';

enum ListType { serious, fake, blank }

class Contender {
  late String id;
  late String name;
  late String description;
  late ListType listType;
  late List<Member> members;
  late Section section;
  late String program;

  Contender({
    required this.id,
    required this.name,
    required this.description,
    required this.listType,
    required this.members,
    required this.section,
    required this.program,
  });

  Contender copyWith({
    String? id,
    String? name,
    String? description,
    ListType? listType,
    List<Member>? members,
    Section? section,
    String? program,
  }) {
    return Contender(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      listType: listType ?? this.listType,
      members: members ?? this.members,
      section: section ?? this.section,
      program: program ?? this.program,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': listTypeToString(listType),
      'members': members.map((x) => x.toJson()).toList(),
      'section_id': section.id,
      'program': program,
    };
  }

  factory Contender.fromJson(Map<String, dynamic> map) {
    return Contender(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      listType: stringToListType(map['type']),
      members: List<Member>.from(
        map['members']?.map((x) => Member.fromJson(x)),
      ),
      section: Section.fromJson(map['section']),
      program: map['program'] ?? '',
    );
  }

  Contender.empty() {
    id = '';
    name = '';
    description = '';
    listType = ListType.serious;
    members = [];
    section = Section.empty();
    program = '';
  }

  @override
  String toString() {
    return 'Contender{id: $id, name: $name, description: $description, listType: $listType, members: $members, section: $section, program: $program}';
  }
}
