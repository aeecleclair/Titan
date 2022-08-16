import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';


final loanerProvider = Provider((ref) {
  final loanerId = ref.watch(loanerIdProvider);
  final loanerList = ref.watch(loanerListProvider);
  return loanerList.when(
    data: (loanerList) => loanerList.firstWhere((loaner) => loaner.id == loanerId),
    error: (error, stackTrace) => Loaner.empty(),
    loading: () => Loaner.empty(),
  );
});

