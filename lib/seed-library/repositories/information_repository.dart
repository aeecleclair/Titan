import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/seed-library/class/information.dart';
import 'package:myecl/tools/repository/repository.dart';

class InformationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "seed_library/information";

  InformationRepository(super.ref);

  Future<Information> getInformation() async {
    return Information.fromJson(await getOne(""));
  }

  Future<bool> updateInformation(Information information) async {
    return await update(information.toJson(), "");
  }
}

final informationRepositoryProvider = Provider((ref) {
  return InformationRepository(ref);
});
