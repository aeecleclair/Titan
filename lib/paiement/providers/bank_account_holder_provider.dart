import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/class/bank_account_holder.dart';
import 'package:titan/paiement/repositories/bank_account_holder_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class BankAccountHolderNotifier extends SingleNotifier<BankAccountHolder> {
  final BankAccountHolderRepository bankAccountHolderRepository;
  BankAccountHolderNotifier({required this.bankAccountHolderRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<BankAccountHolder>> getBankAccountHolder() async {
    return await load(bankAccountHolderRepository.getBankAccountHolder);
  }

  Future<bool> updateBankAccountHolder(String structureId) async {
    return await add(
      (_) => bankAccountHolderRepository.updateBankAccountHolder(structureId),
      BankAccountHolder.empty(),
    );
  }
}

final bankAccountHolderProvider =
    StateNotifierProvider<
      BankAccountHolderNotifier,
      AsyncValue<BankAccountHolder>
    >((ref) {
      final bankAccountHolderRepository = ref.watch(
        bankAccountHolderRepositoryProvider,
      );
      return BankAccountHolderNotifier(
        bankAccountHolderRepository: bankAccountHolderRepository,
      )..getBankAccountHolder();
    });
