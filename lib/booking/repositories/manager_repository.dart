import 'package:myecl/booking/class/manager.dart';
import 'package:myecl/tools/repository/repository.dart';

class ManagerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "booking/";

  Future<List<Manager>> getManagerList() async {
    return List<Manager>.from(
        (await getList(suffix: "managers")).map((x) => Manager.fromJson(x)));
  }

  Future<List<Manager>> getMyManager() async {
    return List<Manager>.from((await getList(suffix: "users/me/managers"))
        .map((x) => Manager.fromJson(x)));
  }

  Future<Manager> createManager(Manager manager) async {
    return Manager.fromJson(await create(manager.toJson(), suffix: "managers"));
  }

  Future<bool> updateManager(Manager manager) async {
    return await update(manager.toJson(), "managers/${manager.id}");
  }

  Future<bool> deleteManager(String managerId) async {
    return await delete("managers/$managerId");
  }
}
