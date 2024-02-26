import 'package:myecl/phonebook/class/association_kinds.dart';
import 'package:myecl/phonebook/tools/fake_class.dart';
import 'package:myecl/tools/repository/repository.dart';

class AssociationKindsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phonebook/associations";

  Future<AssociationKinds> getAssociationKinds() async {
    return fakeAssociationKinds ;
    // return AssociationKinds.fromJSON(await getOne("kinds"));
  }
}