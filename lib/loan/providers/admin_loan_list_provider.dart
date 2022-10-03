import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:tuple/tuple.dart';

class AdminLoanListNotifier extends MapNotifier<Loaner, Loan> {
  AdminLoanListNotifier({required String token}) : super(token: token);
}

final adminLoanListProvider = StateNotifierProvider<AdminLoanListNotifier,
    AsyncValue<Map<Loaner, Tuple2<AsyncValue<List<Loan>>, bool>>>>((ref) {
  final token = ref.watch(tokenProvider);
  final loaners = ref.watch(loanerList);
  AdminLoanListNotifier adminloanListNotifier =
      AdminLoanListNotifier(token: token);
  adminloanListNotifier.loadTList(loaners);
  return adminloanListNotifier;
});
