import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ticketing/ui/ticketing.dart';
import 'package:titan/ticketing/ui/pages/form_page/pay_with_HA.dart';
import 'package:titan/mypayment/ui/pages/fund_page/confirm_button.dart';

class FormPage extends HookConsumerWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TicketingTemplate(
      child: Column(
        children: [
          Center(child: Text('Contenu du formulaire de contact')),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Question 1"),
                Text("Question 2"),
                Text("Question 3"),
                const SizedBox(height: 20),
                Spacer(),
                ConfirmTicketButton(),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
