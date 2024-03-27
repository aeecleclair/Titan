import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/repositories/ph_repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PhNotifier extends StateNotifier<Ph> {
  final PhRepository _phRepository = PhRepository();
  PhNotifier({required String token}) : super(Ph.empty()) {
    _phRepository.setToken(token);
  }

  Future<AsyncValue<Ph>> createPh(ph) async {
    return await createPh(() async => _phRepository.createPh(ph));
  }
}

final phProvider = StateNotifierProvider<PhNotifier, Ph>((ref) {
  final token = ref.watch(tokenProvider);
  PhNotifier notifier = PhNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.createPh(Ph);
  });
  return notifier;
});
