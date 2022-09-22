import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

class CashUi extends HookConsumerWidget {
  final Cash c;
  final int i;
  const CashUi({Key? key, required this.c, required this.i}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final amount = useTextEditingController();
    return Container(
      height: 70,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.user.getName(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              Text(
                "${AMAPTextConstants.amount} : ${c.balance.toStringAsFixed(2)}€",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          Form(
            key: key,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: amount,
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? AMAPTextConstants.add : null,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AMAPColorConstants.greenGradient2,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AMAPColorConstants.greenGradient2
                              .withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    if (key.currentState!.validate()) {
                      ref
                          .read(cashProvider.notifier)
                          .updateCash(
                            Cash(
                              user: c.user,
                              balance: c.balance + int.parse(amount.text),
                            ),
                          )
                          .then((value) {
                        if (value) {
                          key.currentState!.reset();
                          displayAMAPToast(context, TypeMsg.msg,
                              AMAPTextConstants.updatedAmount);
                        } else {
                          displayAMAPToast(context, TypeMsg.error,
                              AMAPTextConstants.updatingError);
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
