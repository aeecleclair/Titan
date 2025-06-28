import 'package:titan/phonebook/class/association.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/associations/";

  Future<List<Association>> getAssociationList() async {
    return List<Association>.from(
      (await getList()).map((x) => Association.fromJson(x)),
    );
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

  Future<bool> deactivateAssociation(Association association) async {
    return await update(null, association.id, suffix: "/deactivate");
  }

  Future<bool> updateAssociationGroups(Association association) async {
    return await update(
      {"associated_groups": association.associatedGroups},
      association.id,
      suffix: "/groups",
    );
  }
}
