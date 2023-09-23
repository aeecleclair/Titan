import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/class/equilibrium_transaction.dart';
import 'package:myecl/tricount/providers/sharer_group_list_provider.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_provider.dart';

final crossGroupStatsProvider = Provider<List<EquilibriumTransaction>>((ref) {
  final sharerGroups = ref.watch(sharerGroupListProvider);
  final me = ref.watch(userProvider);
  final crossGroupStats = <SimpleUser, double>{};
  return sharerGroups.maybeWhen(data: (sharerGroups) {
    for (final sharerGroup in sharerGroups) {
      for (final equilibriumTransaction
          in sharerGroup.equilibriumTransactions) {
        if (me.id != equilibriumTransaction.from.id) {
          if (crossGroupStats.containsKey(equilibriumTransaction.from)) {
            crossGroupStats[equilibriumTransaction.from] =
                crossGroupStats[equilibriumTransaction.from]! +
                    equilibriumTransaction.amount;
          } else {
            crossGroupStats[equilibriumTransaction.from] =
                equilibriumTransaction.amount;
          }
        }
        if (me.id != equilibriumTransaction.to.id) {
          if (crossGroupStats.containsKey(equilibriumTransaction.to)) {
            crossGroupStats[equilibriumTransaction.to] =
                crossGroupStats[equilibriumTransaction.to]! -
                    equilibriumTransaction.amount;
          } else {
            crossGroupStats[equilibriumTransaction.to] =
                -equilibriumTransaction.amount;
          }
        }
      }
    }
    return crossGroupStats.entries
        .map((e) => EquilibriumTransaction(
            from: e.value > 0 ? me.toSimpleUser() : e.key,
            to: e.value > 0 ? e.key : me.toSimpleUser(),
            amount: e.value))
        .toList();
  }, orElse: () {
    return [];
  });
});
