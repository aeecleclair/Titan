import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/class/structure.dart';
import 'package:titan/paiement/repositories/bank_account_holder_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class BankAccountHolderNotifier extends SingleNotifier<Structure> {
  final BankAccountHolderRepository bankAccountHolderRepository;
  BankAccountHolderNotifier({required this.bankAccountHolderRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<Structure>> getBankAccountHolder() async {
    return await load(bankAccountHolderRepository.getBankAccountHolder);
  }

  Future<bool> updateBankAccountHolder(Structure structure) async {
    return await add(
      (_) => bankAccountHolderRepository.updateBankAccountHolder(structure),
      structure,
    );
  }
}

final bankAccountHolderProvider =
    StateNotifierProvider<BankAccountHolderNotifier, AsyncValue<Structure>>((
      ref,
    ) {
      final bankAccountHolderRepository = ref.watch(
        bankAccountHolderRepositoryProvider,
      );
      return BankAccountHolderNotifier(
        bankAccountHolderRepository: bankAccountHolderRepository,
      )..getBankAccountHolder();
    });
