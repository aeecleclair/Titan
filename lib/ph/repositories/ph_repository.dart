import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/ph/class/ph.dart';
import 'package:titan/tools/repository/repository.dart';

class PhRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "ph/";

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

final phRepositoryProvider = Provider<PhRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return PhRepository()..setToken(token);
});
