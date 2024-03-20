import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/loan/router.dart';
import 'package:tuple/tuple.dart';

final Map<String, Tuple2<String, List<StateNotifierProvider>>> loanProviders = {
  "userLoans": Tuple2(
    LoanRouter.root,
    [userLoanerListProvider],
  ),
  "delayedLoans": Tuple2(
    LoanRouter.root,
    [userLoanerListProvider],
  ),
  "loans": Tuple2(
    LoanRouter.root,
    [loanListProvider],
  ),
};
