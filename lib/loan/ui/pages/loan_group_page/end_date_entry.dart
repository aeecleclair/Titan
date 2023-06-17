import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/initial_date_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class EndDateEntry extends HookConsumerWidget {
  const EndDateEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final end = ref.watch(endProvider);
    final endNotifier = ref.watch(endProvider.notifier);
    final initialDate = ref.watch(initialDateProvider);
    selectDate(BuildContext context) async {
      final DateTime now = DateTime.now();
      final DateTime? picked = await showDatePicker(
          // locale: const Locale("fr", "FR"),
          context: context,
          initialDate: initialDate,
          firstDate: initialDate,
          lastDate: DateTime(now.year + 1, now.month, now.day),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ColorConstants.gradient1,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          });
      endNotifier.setEnd(processDate(picked ?? now));
    }

    return GestureDetector(
      onTap: () => selectDate(context),
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
