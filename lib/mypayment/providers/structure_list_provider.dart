import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class StructureListNotifier extends ListNotifierAPI<Structure> {
  Openapi get structuresRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Structure>> build() {
    getStructures();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Structure>>> getStructures() async {
    return await loadList(structuresRepository.mypaymentStructuresGet);
  }

  Future<bool> updateStructure(Structure structure) async {
    return await update(
      () => structuresRepository.mypaymentStructuresStructureIdPatch(
        structureId: structure.id,
        body: StructureUpdate(
          name: structure.name,
          siret: structure.siret,
          siegeAddressCity: structure.siegeAddressCity,
          siegeAddressCountry: structure.siegeAddressCountry,
          siegeAddressStreet: structure.siegeAddressStreet,
          siegeAddressZipcode: structure.siegeAddressZipcode,
          iban: structure.iban,
          associationMembershipId: structure.associationMembershipId,
          bic: structure.bic,
        ),
      ),
      (structure) => structure.id,
      structure,
    );
  }

  Future<bool> deleteStructure(Structure structure) async {
    return await delete(
      () => structuresRepository.mypaymentStructuresStructureIdDelete(
        structureId: structure.id,
      ),
      (structure) => structure.id,
      structure.id,
    );
  }

  Future<bool> createStructure(Structure structure) async {
    return await add(
      () => structuresRepository.mypaymentStructuresPost(
        body: StructureBase(
          managerUserId: structure.managerUserId,
          shortId: structure.shortId,
          name: structure.name,
          siret: structure.siret,
          siegeAddressCity: structure.siegeAddressCity,
          siegeAddressCountry: structure.siegeAddressCountry,
          siegeAddressStreet: structure.siegeAddressStreet,
          siegeAddressZipcode: structure.siegeAddressZipcode,
          iban: structure.iban,
          associationMembershipId: structure.associationMembershipId,
          bic: structure.bic,
        ),
      ),
      structure,
    );
  }
}

final structureListProvider =
    NotifierProvider<StructureListNotifier, AsyncValue<List<Structure>>>(
      StructureListNotifier.new,
    );
