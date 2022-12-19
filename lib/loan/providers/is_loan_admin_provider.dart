import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isLoanAdmin = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  final loaners = ref.watch(userLoanerListProvider);
  final myGroupsName = me.groups.map((e) => e.name).toList();
  final loanersName = loaners.when(
      data: (loaners) => loaners.map((e) => e.name).toList(),
      loading: () => [],
      error: (error, stackTrace) => []);
  return myGroupsName.any((element) => loanersName.contains(element));
});
