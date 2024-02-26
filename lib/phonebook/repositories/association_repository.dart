import 'package:flutter/material.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/tools/repository/repository.dart';

class AssociationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/associations/";

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
    //fakeAssociations.removeWhere((element) => element.id == associationId);
    return true;
    //return await delete(associationId);
  }

  Future<bool> updateAssociation(Association association) async {
    //fakeAssociations[fakeAssociations.indexWhere((element) => element.id == association.id)] = association;
    return true;
    //return await update(association.toJSON(), association.id);
  }

  Future<Association> createAssociation(Association association) async {
    List<String> ids = fakeAssociations.map((e) => e.id).toList();
    String newId = "1";
    while (ids.contains(newId)) {
      newId = (int.parse(newId) + 1).toString();
    }
    association = association.copyWith(id: newId);
    return association;
    //return Association.fromJSON(await create(association.toJSON()));
  }

  Future<bool> addMember(Association association, Member member, List<String> rolesTags, String apparentName) async {
    if (fakeMembersList.indexWhere((element) => element.member.id == member.id) == -1) {
      fakeMembersList.add(CompleteMember(member: member, memberships: []));
    }
    if (fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.id)]
            .memberships
            .indexWhere((element) => element.association.id == association.id) !=
        -1) {
      return false;
    }
    fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.id)]
        .memberships
        .add(Membership(association: association, rolesTags: rolesTags, apparentName: apparentName));
    //await create({"member_id": member.id, "association_id": association.id, "rolesTags": rolesTags, "apparentName": apparentName"},
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

  Future<bool> updateMember(Association association, Member member, List<String> rolesTags, String apparentName) async {
    debugPrint("updateMember");
    fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.id)]
        .memberships
        .where((element) => element.association.id == association.id).toList()[0] = 
          Membership(association: association, rolesTags: rolesTags, apparentName: apparentName);
    //await update({"member_id": member.id, "association_id": association.id, "rolesTags": rolesTags, "apparentName": apparentName"},
    //    suffix: "membership");
    return true;
  }
}
