import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/raffle/class/prize.dart';
import 'package:myecl/raffle/providers/prize_list_provider.dart';
import 'package:myecl/raffle/providers/prize_provider.dart';
import 'package:myecl/raffle/providers/raffle_provider.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/pages/admin_page/blue_btn.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditLotPage extends HookConsumerWidget {
  const AddEditLotPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final raffle = ref.watch(raffleProvider);
    final lot = ref.watch(prizeProvider);
    final isEdit = lot.id != Prize.empty().id;
    final quantity =
        useTextEditingController(text: isEdit ? lot.quantity.toString() : "1");
    final name = useTextEditingController(text: lot.name);
    final description = useTextEditingController(text: lot.description);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
              key: formKey,
              child: Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isEdit
                                ? RaffleTextConstants.editPrize
                                : RaffleTextConstants.addPrize,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              color: RaffleColorConstants.gradient1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Quantité",
                                style: TextStyle(
                                    color: RaffleColorConstants.gradient2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEntry(
                            label: "Quantité",
                            isInt: true,
                            validator: (value) {
                              if (int.parse(value) < 1) {
                                return RaffleTextConstants.mustBePositive;
                              }
                              return null;
                            },
                            controller: quantity,
                            keyboardType: TextInputType.number),
                        const SizedBox(
                          height: 50,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Nom",
                                style: TextStyle(
                                    color: RaffleColorConstants.gradient2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEntry(
                            label: "Nom",
                            controller: name,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 50,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Description",
                                style: TextStyle(
                                    color: RaffleColorConstants.gradient2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                        const SizedBox(
                          height: 5,
                        ),
                        TextEntry(
                            label: "Description",
                            canBeEmpty: true,
                            controller: description,
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 50,
                        ),
                        WaitingButton(
                            builder: (child) => BlueBtn(child: child),
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await tokenExpireWrapper(ref, () async {
                                  final newlot = lot.copyWith(
                                      name: name.text,
                                      description: description.text,
                                      raffleId:
                                          isEdit ? lot.raffleId : raffle.id,
                                      quantity: int.parse(quantity.text));
                                  final lotNotifier =
                                      ref.watch(prizeListProvider.notifier);
                                  final value = isEdit
                                      ? await lotNotifier.updatePrize(newlot)
                                      : await lotNotifier.addPrize(newlot);
                                  if (value) {
                                    QR.back();
                                    if (isEdit) {
                                      displayToastWithContext(
                                          TypeMsg.msg, "Lot modifié");
                                    } else {
                                      displayToastWithContext(
                                          TypeMsg.msg, "Lot ajouté");
                                    }
                                  } else {
                                    if (isEdit) {
                                      displayToastWithContext(TypeMsg.error,
                                          RaffleTextConstants.editingError);
                                    } else {
                                      displayToastWithContext(TypeMsg.error,
                                          RaffleTextConstants.addingError);
                                    }
                                  }
                                });
                              } else {
                                displayToast(context, TypeMsg.error,
                                    RaffleTextConstants.addingError);
                              }
                            },
                            child: Text(isEdit
                                ? RaffleTextConstants.edit
                                : RaffleTextConstants.add)),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )))),
    );
  }
}
