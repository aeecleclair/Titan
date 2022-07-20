import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/association_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';

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
    if (l.isEmpty) {
      return '';
    } else {
      return l.first;
    }
  }, error: (e, s) {
    return "";
  }, loading: () {
    return "";
  }));
});

final associationFromLoanProvider =
    StateNotifierProvider<AssociationNotifier, String>((ref) {
  final loan = ref.watch(loanProvider);
  return AssociationNotifier(loan.when(data: (l) {
    return l.association;
  }, error: (e, s) {
    return "";
  }, loading: () {
    return "";
  }));
});
