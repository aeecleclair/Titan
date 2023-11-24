import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tricount/class/balance.dart';
import 'package:myecl/tricount/providers/membership_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_membership_map_provider.dart';
import 'package:myecl/user/providers/user_provider.dart';

final crossGroupStatsProvider = Provider<List<Balance>>((ref) {
  final sharerGroups = ref.watch(sharerGroupMapProvider);
  final memberList = ref.watch(membershipListProvider);
  final me = ref.watch(userProvider);
  final crossGroupStats = <String, double>{};
  return memberList.maybeWhen(
      data: (members) {
        return sharerGroups.maybeWhen(
            data: (sharerGroups) {
              for (final member in members) {
                final group = sharerGroups[member];
                if (group == null) {
                  continue;
                }
                group.maybeWhen(
                    data: (sharerGroup) {
                      for (final balance in sharerGroup.first.balances) {
                        if (me.id == balance.userId) {
                          if (crossGroupStats
                              .containsKey(balance.reimbursementId)) {
                            crossGroupStats[balance.reimbursementId] =
                                crossGroupStats[balance.reimbursementId]! -
                                    balance.amount;
                          } else {
                            crossGroupStats[balance.reimbursementId] =
                                -balance.amount;
                          }
                        }
                        if (me.id == balance.reimbursementId) {
                          if (crossGroupStats.containsKey(balance.userId)) {
                            crossGroupStats[balance.userId] =
                                crossGroupStats[balance.userId]! +
                                    balance.amount;
                          } else {
                            crossGroupStats[balance.userId] = balance.amount;
                          }
                        }
                      }
                    },
                    orElse: () {});
              }
              return crossGroupStats.entries
                  .map((e) => Balance(
                      userId: e.value > 0 ? me.id : e.key,
                      reimbursementId: e.value > 0 ? e.key : me.id,
                      totalExpense: 0,
                      totalPayment: 0,
                      amount: e.value.abs()))
                  .toList();
            },
            orElse: () => []);
      },
      orElse: () => []);
});
