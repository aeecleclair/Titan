import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/providers/bank_account_holder_provider.dart';
import 'package:titan/paiement/providers/my_structures_provider.dart';

final isStructureAdminProvider = StateProvider((ref) {
  final myStructures = ref.watch(myStructuresProvider);
  return myStructures.isNotEmpty;
});

final isBankAccountHolderProvider = Provider((ref) {
  final bankAccountHolder = ref.watch(bankAccountHolderProvider);
  final myStructures = ref.watch(myStructuresProvider);
  return bankAccountHolder.maybeWhen(
    data: (bankAccountHolder) {
      return myStructures.any(
        (structure) => structure.id == bankAccountHolder.holderStructureId,
      );
    },
    orElse: () => false,
  );
});
