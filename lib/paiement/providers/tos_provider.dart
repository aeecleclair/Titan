import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/tos.dart';
import 'package:myecl/paiement/repositories/tos_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class TOSNotifier extends SingleNotifier<TOS> {
  final TosRepository tosRepository;
  TOSNotifier({required this.tosRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<TOS>> getTOS() async {
    return await load(tosRepository.getTOS);
  }

  Future<bool> signTOS(TOS tos) async {
    return await update(tosRepository.signTOS, tos);
  }
}

final tosProvider = StateNotifierProvider<TOSNotifier, AsyncValue<TOS>>((ref) {
  final tosRepository = ref.watch(tosRepositoryProvider);
  return TOSNotifier(tosRepository: tosRepository)..getTOS();
});
