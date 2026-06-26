import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class BankAccountHolderNotifier extends SingleNotifierAPI<Structure> {
  Openapi get bankAccountHolderRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<Structure> build() {
    getBankAccountHolder();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<Structure>> getBankAccountHolder() async {
    return await load(
      bankAccountHolderRepository.mypaymentBankAccountHolderGet,
    );
  }

  Future<bool> addBankAccountHolder(Structure structure) async {
    return await add(
      (_) => bankAccountHolderRepository.mypaymentBankAccountHolderPost(
        body: MyPaymentBankAccountHolder(holderStructureId: structure.id),
      ),
      structure,
    );
  }
}

final bankAccountHolderProvider =
    NotifierProvider<BankAccountHolderNotifier, AsyncValue<Structure>>(
      BankAccountHolderNotifier.new,
    );
