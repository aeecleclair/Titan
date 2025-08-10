import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationGroupementRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/groupements/";

  Future<List<AssociationGroupement>> getAssociationGroupements() async {
    return List<AssociationGroupement>.from(
      (await getList()).map((x) => AssociationGroupement.fromJson(x)),
    );
  }

  Future<AssociationGroupement> getAssociationGroupementById(String id) async {
    return AssociationGroupement.fromJson(await getOne(id));
  }

  Future<bool> updateAssociationGroupement(
    AssociationGroupement associationGroupement,
  ) async {
    return await update(
      associationGroupement.toJson(),
      associationGroupement.id,
    );
  }

  Future<AssociationGroupement> createAssociationGroupement(
    AssociationGroupement associationGroupement,
  ) async {
    return AssociationGroupement.fromJson(
      await create(associationGroupement.toJson()),
    );
  }

  Future<bool> deleteAssociationGroupement(String id) async {
    return await delete(id);
  }
}
