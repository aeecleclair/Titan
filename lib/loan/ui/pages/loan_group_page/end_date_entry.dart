import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/initial_date_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class EndDateEntry extends HookConsumerWidget {
  const EndDateEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final end = ref.watch(endProvider);
    final endNotifier = ref.watch(endProvider.notifier);
    final initialDate = ref.watch(initialDateProvider);

    return GestureDetector(
      onTap: () => getOnlyDayDateFunction(context, endNotifier.setEnd,
          initialDate: initialDate),
      child: SizedBox(
        child: AbsorbPointer(
          child: TextFormField(
            controller: TextEditingController(text: end),
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              labelText: LoanTextConstants.endDate,
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return LoanTextConstants.enterDate;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
