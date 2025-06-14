import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/repositories/ph_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class PhListNotifier extends ListNotifier<Ph> {
  final PhRepository _phRepository;
  PhListNotifier(this._phRepository) : super(const AsyncValue.loading());

  Future<AsyncValue<List<Ph>>> loadPhList() async {
    return await loadList(() async => _phRepository.getAllPh());
  }

  Future<bool> addPh(Ph ph) async {
    return await add(_phRepository.addPh, ph);
  }

  Future<bool> editPh(Ph ph) async {
    return await update(
      _phRepository.editPh,
      (phs, ph) =>
          phs..[phs.indexWhere((phToCheck) => phToCheck.id == ph.id)] = ph,
      ph,
    );
  }

  Future<bool> deletePh(Ph ph) async {
    return await delete(
      _phRepository.deletePh,
      (phs, ph) => phs..removeWhere((phToCheck) => phToCheck.id == ph.id),
      ph.id,
      ph,
    );
  }
}

final phListProvider =
    StateNotifierProvider<PhListNotifier, AsyncValue<List<Ph>>>((ref) {
      final repository = ref.watch(phRepositoryProvider);
      final notifier = PhListNotifier(repository);
      notifier.loadPhList();
      return notifier;
    });
