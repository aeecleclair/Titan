import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/repositories/loaner_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class LoanerNotifier extends SingleNotifier<Loaner> {
  final LoanerRepository _loanerRepository = LoanerRepository();
  LoanerNotifier({required String token}) : super(const AsyncValue.loading()) {
    _loanerRepository.setToken(token);
  }

  Future<AsyncValue<Loaner>> loadLoaner(String loanerId) async {
    return await load(() async => _loanerRepository.getLoaner(loanerId));
  }

  Future<bool> addLoaner(Loaner loaner) async {
    return await add(_loanerRepository.createLoaner, loaner);
  }

  Future<bool> updateLoaner(Loaner loaner) async {
    return await update(_loanerRepository.updateLoaner, loaner);
  }

  Future<bool> deleteLoaner(Loaner loaner) async {
    return await delete(_loanerRepository.deleteLoaner, loaner, loaner.id);
  }
}

final loanerProvider =
    StateNotifierProvider<LoanerNotifier, AsyncValue<Loaner>>((ref) {
  final token = ref.watch(tokenProvider);
  LoanerNotifier _orderListNotifier = LoanerNotifier(token: token);
  return _orderListNotifier;
});

final loanerName = Provider((ref) {
  final loaner = ref.watch(loanerProvider);
  return loaner.when(
    data: (loaner) => loaner.name,
    error: (error, stackTrace) => "",
    loading: () => "",
  );
});
