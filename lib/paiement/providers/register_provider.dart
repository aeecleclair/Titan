import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/repositories/users_me_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class RegisterNotifier extends SingleNotifier<bool> {
  final UsersMeRepository usersMeRepository;
  RegisterNotifier({required this.usersMeRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<bool>> register() async {
    return await load(usersMeRepository.register);
  }
}

final registerProvider =
    StateNotifierProvider<RegisterNotifier, AsyncValue<bool>>((ref) {
      final registerRepository = ref.watch(usersMeRepositoryProvider);
      return RegisterNotifier(usersMeRepository: registerRepository);
    });
