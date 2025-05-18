import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/vote/adapters/member.dart';

extension $ListReturn on ListReturn {
  ListBase toListBase() {
    return ListBase(
      name: name,
      description: description,
      type: type,
      sectionId: section.id,
      members: members.map((e) => e.toMemberBase()).toList(),
    );
  }

  ListEdit toListEdit() {
    return ListEdit(
      name: name,
      description: description,
      type: type,
      program: program,
      members: members.map((e) => e.toMemberBase()).toList(),
    );
  }
}
