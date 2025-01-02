import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/cgu.dart';
import 'package:myecl/paiement/repositories/cgu_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class CGUNotifier extends SingleNotifier<CGU> {
  final CguRepository cguRepository;
  CGUNotifier({required this.cguRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<CGU>> getCGU() async {
    return await load(cguRepository.getCGU);
  }

  Future<bool> signCGU(CGU cgu) async {
    return await update(cguRepository.signCGU, cgu);
  }
}

final cguProvider = StateNotifierProvider<CGUNotifier, AsyncValue<CGU>>((ref) {
  final cguRepository = ref.watch(cguRepositoryProvider);
  return CGUNotifier(cguRepository: cguRepository)..getCGU();
});
