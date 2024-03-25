import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/class/ph_admin.dart';
import 'package:myecl/tools/repository/repository.dart';

class PhRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "phs/";

  Future<List<PhAdmin>> getPhAdminList() async {
    return List<PhAdmin>.from(
        (await getList(suffix: "ph_admins/")).map((x) => PhAdmin.fromJson(x)));
  }

  Future<List<Ph>> getMyPhList() async {
    return List<Ph>.from(
        (await getList(suffix: "users/me")).map((x) => Ph.fromJson(x)));
  }

  final phRepositoryProvider = Provider<PhRepository>((ref) {
    final token = ref.watch(tokenProvider);
    return PhRepository()..setToken(token);
  });
}
