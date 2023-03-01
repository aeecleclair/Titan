import 'package:myecl/amap/class/information.dart';
import 'package:myecl/tools/repository/repository.dart';

class InformationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/information";

  Future<Information> getInformation() async {
    return Information.fromJson(await getOne(""));
  }

  Future<Information> createInformation(Information information) async {
    return Information.fromJson(await create(information.toJson()));
  }

  Future<bool> updateInformation(Information information) async {
    return await update(information.toJson(), "");
  }

  Future<bool> deleteInformation(String id) async {
    return await delete(id);
  }
}