import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/structure.dart';
import 'package:myecl/paiement/repositories/structures_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class StructureListNotifier extends ListNotifier<Structure> {
  final StructuresRepository structuresRepository;
  StructureListNotifier({required this.structuresRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Structure>>> getStructures() async {
    return await loadList(structuresRepository.getStructures);
  }

  Future<bool> updateStructure(Structure structure) async {
    return await update(
      structuresRepository.updateStructure,
      (structures, structure) =>
          structures
            ..[structures.indexWhere((s) => s.id == structure.id)] = structure,
      structure,
    );
  }

  Future<bool> deleteStructure(Structure structure) async {
    return await delete(
      (id) => structuresRepository.deleteStructure(id),
      (structures, structure) =>
          structures..removeWhere((s) => s.id == structure.id),
      structure.id,
      structure,
    );
  }

  Future<bool> createStructure(Structure structure) async {
    return await add(structuresRepository.createStructure, structure);
  }
}

final structureListProvider =
    StateNotifierProvider<StructureListNotifier, AsyncValue<List<Structure>>>((
      ref,
    ) {
      final structureRepository = ref.watch(structuresRepositoryProvider);
      final notifier = StructureListNotifier(
        structuresRepository: structureRepository,
      )..getStructures();
      return notifier;
    });
