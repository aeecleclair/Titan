import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/repositories/ph_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

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
}

final phListProvider =
    StateNotifierProvider<PhListNotifier, AsyncValue<List<Ph>>>((ref) {
  final token = ref.watch(tokenProvider);
  PhListNotifier notifier = PhListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadPhList();
  });
  return notifier;
});
