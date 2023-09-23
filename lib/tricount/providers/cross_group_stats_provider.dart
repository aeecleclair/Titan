import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/providers/sharer_group_list_provider.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_provider.dart';

final crossGroupStatsProvider = Provider<Map<SimpleUser, double>>((ref) {
  final sharerGroups = ref.watch(sharerGroupListProvider);
  final me = ref.watch(userProvider);
  final crossGroupStats = <SimpleUser, double>{};
  sharerGroups.whenData((sharerGroups) {
    for (final sharerGroup in sharerGroups) {
      for (final equilibriumTransaction in sharerGroup.equilibriumTransactions) {
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
  }});
  return crossGroupStats;
});