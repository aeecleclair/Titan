import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/class/role.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myecl/tools/exception.dart';

class AssociationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/association/";

  Future<List<Association>> getAssociationList() async {
    return fakeAssociations;
    //return List<Association>.from(
    //    (await getList()).map((x) => Association.fromJSON(x)));
  }

  Future<Association> getAssociation(String associationId) async {
    return fakeAssociations.firstWhere((element) => element.id == associationId);
    //return Association.fromJSON(await getOne(associationId));
  }

  Future<bool> deleteAssociation(String associationId) async {
    fakeAssociations.removeWhere((element) => element.id == associationId);
    return true;
    //return await delete(associationId);
  }

  Future<bool> updateAssociation(Association association) async {
    fakeAssociations[fakeAssociations.indexWhere((element) => element.id == association.id)] = association;
    return true;
    //return await update(association.toJSON(), association.id);
  }

  Future<Association> createAssociation(Association association) async {
    List<String> ids = fakeAssociations.map((e) => e.id).toList();
    String newId = "1";
    while (ids.contains(newId)) {
      newId = (int.parse(newId) + 1).toString();
    }
    association.id = newId;
    fakeAssociations.add(association);
    return association;
    //return Association.fromJSON(await create(association.toJSON()));
  }

  Future<bool> addMember(Association association, CompleteMember member, Role role) async {
    fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.member.id)]
        .memberships
        .add(Membership(association: association, role: role));
    //await create({"member_id": member.member.id, "association_id": association.id, "roleId": role.id},
    //    suffix: "membership");
    return true;
  }

  Future<bool> deleteMember(Association association, CompleteMember member) async {
    fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.member.id)]
        .memberships
        .removeWhere((element) => element.association.id == association.id);
    return true;
    //final response = await http.delete(
    //    Uri.parse("$host${ext}membership"),
    //     headers: headers,
    //     body: json.encode({"member_id": member.member.id, "association_id": association.id}));
    // if (response.statusCode == 204) {
    //   return true;
    // } else if (response.statusCode == 403) {
    //   throw AppException(ErrorType.tokenExpire, response.body);
    // } else {
    //   throw AppException(ErrorType.notFound, "Failed to update item");
    // }
  }
}
