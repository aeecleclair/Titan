import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class RegisterNotifier extends SingleNotifierAPI<bool> {
  Openapi get usersMeRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<bool> build() {
    return const AsyncValue.loading();
  }

  Future<bool> register() async {
    return (await usersMeRepository.mypaymentUsersMeRegisterPost())
        .isSuccessful;
  }
}

final registerProvider = NotifierProvider<RegisterNotifier, AsyncValue<bool>>(
  RegisterNotifier.new,
);
