import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/class/structure.dart';
import 'package:titan/mypayment/repositories/structures_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/user/class/simple_users.dart';

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

  Future<SimpleUser> addStructureAdministrator(
    Structure structure,
    String userId,
  ) async {
    final newAdmin = await structuresRepository.addStructureAdmin(
      structure,
      userId,
    );
    await update((structure) => Future(() => true), (structures, structure) {
      final index = structures.indexWhere((s) => s.id == structure.id);
      if (index != -1) {
        structures[index].administrators.add(newAdmin);
      }
      return structures;
    }, structure);
    return newAdmin;
  }

  Future<bool> removeStructureAdministrator(
    Structure structure,
    String userId,
  ) async {
    return await delete(
      (id) => structuresRepository.removeStructureAdmin(structure, id),
      (structures, structure) {
        final index = structures.indexWhere((s) => s.id == structure.id);
        if (index != -1) {
          structures[index].administrators.removeWhere(
            (admin) => admin.id == userId,
          );
        }
        return structures;
      },
      userId,
      structure,
    );
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
