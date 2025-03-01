import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/vote/adapters/member.dart';

extension $ListReturn on ListReturn {
  ListBase toListBase() {
    return ListBase(name: name, description: description, type: type, sectionId: section.id, members: members.map((e) => e.toMemberBase()).toList());
  }
}