import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/date_entry.dart';

class EndDateEntry extends HookConsumerWidget {
  final ValueNotifier<DateTime> initialDate;
  const EndDateEntry({Key? key, required this.initialDate}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final end = ref.watch(endProvider);
    return DateEntry(
      title: LoanTextConstants.endDate,
      controller: end,
      dateBefore: initialDate.value,
      onSelect: () {},
    );
  }
}
