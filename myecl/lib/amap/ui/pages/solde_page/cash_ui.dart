import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/tools/functions.dart';

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
              Text(
                  c.user.nickname.isNotEmpty
                      ? c.user.nickname +
                          " (" +
                          c.user.firstname +
                          " " +
                          c.user.name +
                          ")"
                      : c.user.firstname + " " + c.user.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(
                "Solde : " + c.balance.toStringAsFixed(2) + "€",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          Form(
            key: key,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
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
                            displayToast(
                                context, TypeMsg.msg, "Solde mis à jour");
                          } else {
                            displayToast(context, TypeMsg.error,
                                "Erreur lors de la mise à jour du solde");
                          }
                        });
                      }
                    },
                    icon: const Icon(Icons.add)),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: amount,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {},
                    validator: (value) => value!.isEmpty
                        ? "Veuillez entrer un montant à ajouter"
                        : null,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        ref
                            .read(cashProvider.notifier)
                            .updateCash(
                              Cash(
                                user: c.user,
                                balance: c.balance - int.parse(amount.text),
                              ),
                            )
                            .then((value) {
                          if (value) {
                            key.currentState!.reset();
                            displayToast(
                                context, TypeMsg.msg, "Solde mis à jour");
                          } else {
                            displayToast(context, TypeMsg.error,
                                "Erreur lors de la mise à jour du solde");
                          }
                        });
                      }
                    },
                    icon: const Icon(Icons.remove)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
