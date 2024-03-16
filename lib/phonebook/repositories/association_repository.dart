import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/tools/repository/repository.dart';

class AssociationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/associations/";

  Future<List<Association>> getAssociationList() async {
    return List<Association>.from(
      (await getList()).map((x) => Association.fromJson(x)),
    );
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

  Future<AssociationKinds> getAssociationKinds() async {
    return AssociationKinds.fromJson(await getOne("kinds"));
  }
}
