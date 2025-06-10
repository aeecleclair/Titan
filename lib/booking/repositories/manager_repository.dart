import 'package:titan/booking/class/manager.dart';
import 'package:titan/tools/repository/repository.dart';

class ManagerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "booking/managers";

  Future<List<Manager>> getManagerList() async {
    return List<Manager>.from(
      (await getList()).map((x) => Manager.fromJson(x)),
    );
  }

  Future<List<Manager>> getUserManagerList() async {
    return List<Manager>.from(
      (await getList(suffix: "/users/me")).map((x) => Manager.fromJson(x)),
    );
  }

  Future<Manager> createManager(Manager manager) async {
    return Manager.fromJson(await create(manager.toJson()));
  }

  Future<bool> updateManager(Manager manager) async {
    return await update(manager.toJson(), "/${manager.id}");
  }

  Future<bool> deleteManager(String managerId) async {
    return await delete("/$managerId");
  }
}
