import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/mypayment/providers/bank_account_holder_provider.dart';
import 'package:titan/mypayment/providers/my_structures_provider.dart';
import 'package:titan/user/providers/user_provider.dart';

final isStructureAdminProvider = StateProvider((ref) {
  final myStructures = ref.watch(myStructuresProvider);
  return myStructures.isNotEmpty;
});

final isStructureManagerProvider = StateProvider((ref) {
  final myStructures = ref.watch(myStructuresProvider);
  final me = ref.watch(userProvider);
  return myStructures.any((structure) => structure.managerUser.id == me.id);
});

final isBankAccountHolderProvider = Provider((ref) {
  final bankAccountHolder = ref.watch(bankAccountHolderProvider);
  final myStructures = ref.watch(myStructuresProvider);
  return bankAccountHolder.maybeWhen(
    data: (bankAccountHolder) {
      return myStructures.any(
        (structure) => structure.id == bankAccountHolder.id,
      );
    },
    orElse: () => false,
  );
});
