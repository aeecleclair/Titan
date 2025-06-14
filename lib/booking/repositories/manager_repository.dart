import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/manager.dart';
import 'package:myecl/tools/repository/repository.dart';

class ManagerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "booking/managers";

  ManagerRepository(super.ref);

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

final managerRepositoryProvider = Provider<ManagerRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return ManagerRepository(ref)..setToken(token);
});
