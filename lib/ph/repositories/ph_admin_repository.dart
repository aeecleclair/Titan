import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/ph/class/ph_admin.dart';
import 'package:myecl/tools/repository/repository.dart';

class PhAdminRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phs/";

  Future<List<PhAdmin>> getPhAdminList() async {
    return List<PhAdmin>.from(
        (await getList(suffix: "ph_admins/")).map((x) => PhAdmin.fromJson(x)));
  }

  Future<List<PhAdmin>> getMyPhAdmin() async {
    return List<PhAdmin>.from((await getList(suffix: "users/me/ph_admins"))
        .map((x) => PhAdmin.fromJson(x)));
  }

  Future<PhAdmin> getPhAdmin(String id) async {
    return PhAdmin.fromJson(await getOne("ph_admins/$id"));
  }

  Future<PhAdmin> createPhAdmin(PhAdmin phAdmin) async {
    return PhAdmin.fromJson(
        await create(phAdmin.toJson(), suffix: "ph_admins/"));
  }

  Future<bool> updatePhAdmin(PhAdmin phAdmin) async {
    return await update(phAdmin.toJson(), "ph_admins/${phAdmin.id}");
  }

  Future<bool> deletePhAdmin(String phAdminId) async {
    return await delete("phAdmins/$phAdminId");
  }
}

final phAdminRepositoryProvider = Provider<PhAdminRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return PhAdminRepository()..setToken(token);
});
