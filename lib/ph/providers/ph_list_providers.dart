import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/ph/repositories/ph_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class PhListNotifier extends ListNotifier<Ph> {
  final PhRepository phRepository;
  PhListNotifier({required this.phRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Ph>>> loadLoanList() async {
    return await loadList(phRepository.getMyPhList);
  }
}

final phListProvider =
    StateNotifierProvider<PhListNotifier, AsyncValue<List<Ph>>>((ref) {
  final phRepository = ref.watch(phRepositoryProvider);
  PhListNotifier phListNotifier = PhListNotifier(phRepository: phRepository);
  tokenExpireWrapperAuth(ref, () async {
    await phListNotifier.loadLoanList();
  });
  return phListNotifier;
});
