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
        (await getList()).map((x) => Association.fromJson(x)));
  }

  Future<Association> getAssociation(String associationId) async {
    return Association.fromJson(await getOne(associationId));
  }

  Future<bool> deleteAssociation(String associationId) async {
    return await delete(associationId);
  }

  Future<bool> updateAssociation(Association association) async {
    return await update(association.toJson(), association.id);
  }

  Future<Association> createAssociation(Association association) async {
    return Association.fromJson(await create(association.toJson()));
  }

  Future<bool> addMember(Membership membership) async {
    final value = await create(membership.toJson(), suffix: "memberships");
    return value != null;
  }

  Future<bool> deleteMember(Membership membership) async {
    return await delete("memberships/${membership.id}");
  }

  Future<bool> updateMember(Membership membership) async {
    return await update(membership.toJson(), "memberships/",
        suffix: membership.id);
  }

  Future<AssociationKinds> getAssociationKinds() async {
    return AssociationKinds.fromJson(await getOne("kinds"));
  }
}
