import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/caution_provider.dart';
import 'package:myecl/loan/tools/constants.dart';

class CautionTextEntry extends HookConsumerWidget {
  const CautionTextEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final caution = ref.watch(cautionProvider);

    return TextFormField(
        controller: caution,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          labelText: LoanTextConstants.caution,
          floatingLabelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        validator: (value) {
          if (value == null) {
            return LoanTextConstants.noValue;
          } else if (value.isEmpty) {
            return LoanTextConstants.noValue;
          }
          return null;
        },
      );
  }
}
