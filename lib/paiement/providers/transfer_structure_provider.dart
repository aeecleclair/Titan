import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/structure.dart';
import 'package:myecl/paiement/repositories/structures_repository.dart';

class TransferStructureNotifier extends StateNotifier {
  final StructuresRepository structuresRepository;
  TransferStructureNotifier({required this.structuresRepository})
    : super(const AsyncValue.loading());

  Future<bool> initTransfer(Structure structure, String newUserId) async {
    return await structuresRepository.initializeManagerTransfer(
      structure,
      newUserId,
    );
  }
}

final transferStructureProvider = StateNotifierProvider((ref) {
  final structureRepository = StructuresRepository(ref);
  final notifier = TransferStructureNotifier(
    structuresRepository: structureRepository,
  );
  return notifier;
});
