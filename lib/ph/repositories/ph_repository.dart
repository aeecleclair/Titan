import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/tools/repository/repository.dart';

class PhRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "ph/";

  PhRepository(super.ref);

  Future<List<Ph>> getAllPh() async {
    return (await getList(suffix: '')).map((e) => Ph.fromJson(e)).toList();
  }

  Future<Ph> addPh(Ph ph) async {
    return Ph.fromJson(await create(ph.toJson(), suffix: ''));
  }

  Future<bool> editPh(Ph ph) async {
    return await update(ph.toJson(), ph.id);
  }

  Future<bool> deletePh(String id) async {
    return await delete(id);
  }
}
