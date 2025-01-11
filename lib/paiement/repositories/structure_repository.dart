import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/paiement/class/structure.dart';
import 'package:myecl/tools/repository/repository.dart';

class StructureRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/structures';

  Future<Structure> createStructure(Structure structure) async {
    return Structure.fromJson(
      await create(structure.toJson()),
    );
  }

  Future<List<Structure>> getStructures() async {
    return List<Structure>.from(
      (await getList()).map((e) => Structure.fromJson(e)),
    );
  }

  Future<bool> updateStructure(Structure structure) async {
    return await update(structure.toJson(), structure.id);
  }

  Future<bool> deleteStructure(Structure structure) async {
    return await delete("/${structure.id}");
  }

  Future<bool> initializeManagerTransfer(
      Structure structure, String newManagerUserId) async {
    return await create({
      "new_manager_user_id": newManagerUserId,
    }, suffix: "/${structure.id}/init-manager-transfer");
  }

  Future<List<Store>> getStructureStores(Structure structure) async {
    return List<Store>.from(
      (await getList(suffix: "/${structure.id}/stores"))
          .map((e) => Store.fromJson(e)),
    );
  }
}

final structureRepositoryProvider = Provider<StructureRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return StructureRepository()..setToken(token);
});
