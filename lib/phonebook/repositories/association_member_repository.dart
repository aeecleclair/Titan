import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';

class AssociationMemberRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/association/";

  Future<List<CompleteMember>> getAssociationMemberList(String associationId) async {
    return List<CompleteMember>.from(
        (await getList(suffix: "$associationId/members")).map((x) => CompleteMember.fromJSON(x)));
  }

  Future<bool> addMember(Association association, CompleteMember member, Role role) async {
    await create({"member_id": member.member.id, "association_id": association.id, "roleId": role.id},
        suffix: "membership");
    return true;
  }

  Future<bool> deleteMember(Association association, CompleteMember member) async {
    final response = await http.delete(
        Uri.parse("$host${ext}membership"),
        headers: headers,
        body: json.encode({"member_id": member.member.id, "association_id": association.id}));
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update item");
    }
  }
}