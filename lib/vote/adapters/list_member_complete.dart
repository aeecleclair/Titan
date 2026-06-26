import 'package:titan/generated/openapi.models.swagger.dart';

extension $ListMemberComplete on ListMemberComplete {
  ListMemberBase toMemberBase() {
    return ListMemberBase(userId: userId, role: role);
  }
}
