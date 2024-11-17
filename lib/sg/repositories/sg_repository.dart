import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/sg/class/sg.dart';
import 'package:myecl/tools/repository/repository.dart';

class SgRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "sg/";

  Future<List<Sg>> getAllSg() async {
    return [
      Sg(
        name: "Rando Fondu",
        id: "salut",
        openDate: DateTime(2024, 11, 12),
        closeDate: DateTime(2024, 11, 18),
      ),
      Sg(
        name: "Rando Fondu",
        id: "salut",
        openDate: DateTime(2024, 11, 17, 03, 24, 00),
        closeDate: DateTime(2024, 11, 17, 03, 53, 00),
      ),
    ];
  }

  Future<Sg> addSg(Sg sg) async {
    return Sg.fromJson(await create(sg.toJson(), suffix: ''));
  }

  Future<bool> editSg(Sg sg) async {
    return await update(sg.toJson(), sg.id);
  }

  Future<bool> deleteSg(String id) async {
    return await delete(id);
  }
}

final sgRepositoryProvider = Provider<SgRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return SgRepository()..setToken(token);
});
