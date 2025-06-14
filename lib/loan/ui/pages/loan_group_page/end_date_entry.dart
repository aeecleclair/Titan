import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/providers/end_provider.dart';
import 'package:titan/loan/providers/initial_date_provider.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';

class EndDateEntry extends HookConsumerWidget {
  const EndDateEntry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final end = ref.watch(endProvider);
    final endNotifier = ref.watch(endProvider.notifier);
    final initialDate = ref.watch(initialDateProvider);

    return DateEntry(
      onTap: () => getOnlyDayDateFunction(
        context,
        endNotifier.setEnd,
        initialDate: initialDate,
      ),
      controller: TextEditingController(text: end),
      label: LoanTextConstants.endDate,
    );
  }
}
