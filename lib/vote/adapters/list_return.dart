import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/vote/adapters/list_member_complete.dart';

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
}
