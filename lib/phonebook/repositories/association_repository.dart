import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/class/member.dart';
import 'package:myecl/phonebook/class/membership.dart';
import 'package:myecl/tools/repository/repository.dart';

class AssociationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/associations/";

  Future<List<Association>> getAssociationList() async {
    return List<Association>.from(
        (await getList()).map((x) => Association.fromJSON(x)));
  }

  Future<Association> getAssociation(String associationId) async {
    return Association.fromJSON(await getOne(associationId));
  }

  Future<bool> deleteAssociation(String associationId) async {
    return await delete(associationId);
  }

  Future<bool> updateAssociation(Association association) async {
    return await update(association.toJSON(), association.id);
  }

  Future<Association> createAssociation(Association association) async {
    return Association.fromJSON(await create(association.toJSON()));
  }

  Future<bool> addMember(Association association, Member member,
      List<String> rolesTags, String apparentName) async {
    return await create({
      "member_id": member.id,
      "association_id": association.id,
      "rolesTags": rolesTags,
      "apparentName": apparentName
    }, suffix: "memberships");
  }

  Future<bool> deleteMember(Membership membership) async {
    return await delete("/memberships/${membership.id}");
  }

  Future<bool> updateMember(Association association, Member member,
      List<String> rolesTags, String apparentName) async {
    return await update({
      "member_id": member.id,
      "association_id": association.id,
      "rolesTags": rolesTags,
      "apparentName": apparentName
    }, association.id, suffix: "memberships");
  }

  Future<AssociationKinds> getAssociationKinds() async {
    return AssociationKinds.fromJSON(await getOne("kinds"));
  }
}
