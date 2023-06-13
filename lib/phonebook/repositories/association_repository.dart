import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/repository/repository.dart';

class AssociationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/associations/";

  Future<List<Association>> getAssociationList() async {
    // return fakeAssociations;
    return List<Association>.from(
       (await getList()).map((x) => Association.fromJSON(x)));
  }

  Future<Association> getAssociation(String associationId) async {
    // return fakeAssociations.firstWhere((element) => element.id == associationId);
    return Association.fromJSON(await getOne(associationId));
  }

  Future<bool> deleteAssociation(String associationId) async {
    //fakeAssociations.removeWhere((element) => element.id == associationId);
    // return true;
    return await delete(associationId);
  }

  Future<bool> updateAssociation(Association association) async {
    //fakeAssociations[fakeAssociations.indexWhere((element) => element.id == association.id)] = association;
    // return true;
    return await update(association.toJSON(), association.id);
  }

  Future<Association> createAssociation(Association association) async {
    // List<String> ids = fakeAssociations.map((e) => e.id).toList();
    // String newId = "1";
    // while (ids.contains(newId)) {
    //   newId = (int.parse(newId) + 1).toString();
    // }
    // association = association.copyWith(id: newId);
    // return association;
    return Association.fromJSON(await create(association.toJSON()));
  }

  Future<bool> addMember(Association association, Member member, List<String> rolesTags, String apparentName) async {
    // if (fakeMembersList.indexWhere((element) => element.member.id == member.id) == -1) {
    //   fakeMembersList.add(CompleteMember(member: member, memberships: []));
    // }
    // if (fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.id)]
    //         .memberships
    //         .indexWhere((element) => element.association.id == association.id) !=
    //     -1) {
    //   return false;
    // }
    // fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.id)]
    //     .memberships
    //     .add(Membership(association: association, rolesTags: rolesTags, apparentName: apparentName));
    return await create({"member_id": member.id, "association_id": association.id, "rolesTags": rolesTags, "apparentName": apparentName},
       suffix: "memberships");
    // return true;
  }

  Future<bool> deleteMember(Membership membership) async {
    // fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.member.id)]
    //     .memberships
    //     .removeWhere((element) => element.association.id == association.id);
    // return true;
    final response = await http.delete(
       Uri.parse("$host${ext}memberships/${membership.id}"),
        headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 403) {
      throw AppException(ErrorType.tokenExpire, response.body);
    } else {
      throw AppException(ErrorType.notFound, "Failed to update item");
    }
  }

  Future<bool> updateMember(Association association, Member member, List<String> rolesTags, String apparentName) async {
    // debugPrint("updateMember");
    // fakeMembersList[fakeMembersList.indexWhere((element) => element.member.id == member.id)]
    //     .memberships
    //     .where((element) => element.association.id == association.id).toList()[0] = 
    //       Membership(association: association, rolesTags: rolesTags, apparentName: apparentName);
    return await update({"member_id": member.id, "association_id": association.id, "rolesTags": rolesTags, "apparentName": apparentName}, association.id,
       suffix: "memberships");
    // return true;
  }

  Future<AssociationKinds> getAssociationKinds() async {
    // return fakeAssociationKinds ;
    return AssociationKinds.fromJSON(await getOne("kinds"));
  }
}
