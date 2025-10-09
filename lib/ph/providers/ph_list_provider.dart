import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/ph/class/ph.dart';
import 'package:titan/ph/repositories/ph_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class PhListNotifier extends ListNotifier<Ph> {
  final PhRepository _phRepository = PhRepository();
  PhListNotifier({required String token}) : super(const AsyncValue.loading()) {
    _phRepository.setToken(token);
  }

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
      final token = ref.watch(tokenProvider);
      final notifier = PhListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadPhList();
      });
      return notifier;
    });
