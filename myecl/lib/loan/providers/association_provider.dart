import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/association_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';

class AssociationNotifier extends StateNotifier<String> {
  AssociationNotifier(String s) : super(s);

  void update(String s) {
    state = s;
  }
}

final associationFromListProvider =
    StateNotifierProvider<AssociationNotifier, String>((ref) {
  final associations = ref.watch(associationListProvider);
  return AssociationNotifier(associations.when(data: (l) {
    return l[0];
  }, error: (e, s) {
    return "";
  }, loading: () {
    return "";
  }));
});

final associationFromLoanProvider =
    StateNotifierProvider<AssociationNotifier, String>((ref) {
  final loan = ref.watch(loanProvider);
  print("loan: $loan");
  return AssociationNotifier(loan.when(data: (l) {
    return l.association;
  }, error: (e, s) {
    return "";
  }, loading: () {
    return "";
  }));
});
