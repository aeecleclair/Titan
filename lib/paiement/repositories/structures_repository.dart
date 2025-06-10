import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/paiement/class/store.dart';
import 'package:titan/paiement/class/structure.dart';
import 'package:titan/tools/repository/repository.dart';

class StructuresRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/structures';

  Future<Structure> createStructure(Structure structure) async {
    return Structure.fromJson(await create(structure.toJson()));
  }

  Future<List<Structure>> getStructures() async {
    return List<Structure>.from(
      (await getList()).map((e) => Structure.fromJson(e)),
    );
  }

  Future<bool> updateStructure(Structure structure) async {
    return await update(structure.toJson(), "/${structure.id}");
  }

  Future<bool> deleteStructure(String structureId) async {
    return await delete("/$structureId");
  }

  Future<bool> initializeManagerTransfer(
    Structure structure,
    String newManagerUserId,
  ) async {
    return await create({
      "new_manager_user_id": newManagerUserId,
    }, suffix: "/${structure.id}/init-manager-transfer");
  }

  Future<List<Store>> getStructureStores(String structureId) async {
    return List<Store>.from(
      (await getList(
        suffix: "/$structureId/stores",
      )).map((e) => Store.fromJson(e)),
    );
  }

  Future<Store> addStructureStore(Structure structure, Store store) async {
    return Store.fromJson(
      await create(store.toJson(), suffix: "/${structure.id}/stores"),
    );
  }
}

final structuresRepositoryProvider = Provider<StructuresRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return StructuresRepository()..setToken(token);
});
