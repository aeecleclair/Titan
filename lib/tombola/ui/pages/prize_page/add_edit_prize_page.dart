import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/class/prize.dart';
import 'package:myecl/tombola/providers/prize_list_provider.dart';
import 'package:myecl/tombola/providers/prize_provider.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/blue_btn.dart';
import 'package:myecl/tombola/ui/text_entry.dart';
import 'package:myecl/tombola/ui/tombola.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditLotPage extends HookConsumerWidget {
  const AddEditLotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final raffle = ref.watch(raffleProvider);
    final lot = ref.watch(prizeProvider);
    final isEdit = lot.id != Prize.empty().id;
    final quantity = useTextEditingController(
        text: isEdit ? lot.quantity.toString() : "1");
    final name = useTextEditingController(text: lot.name);
    final description = useTextEditingController(text: lot.description);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return TombolaTemplate(
      child: Container(
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
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              TombolaTextConstants.addlot,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 25,
                                color: TombolaColorConstants.gradient1,
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
                                      color: TombolaColorConstants.gradient2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                          const SizedBox(
                            height: 5,
                          ),
                          TextEntry(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TombolaTextConstants.fillField;
                                }
                                if (int.tryParse(value) == null) {
                                  return TombolaTextConstants.numberExpected;
                                }
                                if (int.parse(value) < 1) {
                                  return TombolaTextConstants.mustBePositive;
                                }
                                return null;
                              },
                              textEditingController: quantity,
                              keyboardType: TextInputType.number),
                          const SizedBox(
                            height: 50,
                          ),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Nom",
                                  style: TextStyle(
                                      color: TombolaColorConstants.gradient2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                          const SizedBox(
                            height: 5,
                          ),
                          TextEntry(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TombolaTextConstants.fillField;
                                }
                                return null;
                              },
                              textEditingController: name,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 50,
                          ),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Description",
                                  style: TextStyle(
                                      color: TombolaColorConstants.gradient2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                          const SizedBox(
                            height: 5,
                          ),
                          TextEntry(
                              validator: (value) => null,
                              textEditingController: description,
                              keyboardType: TextInputType.text),
                          const SizedBox(
                            height: 50,
                          ),
                          ShrinkButton(
                              waitChild: const BlueBtn(
                                  text: TombolaTextConstants.waiting),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await tokenExpireWrapper(ref, () async {
                                    final newlot = lot.copyWith(
                                        name: name.text,
                                        description: description.text,
                                        raffleId: isEdit ? lot.raffleId : raffle.id,
                                        quantity: int.parse(quantity.text));
                                    final lotNotifier = ref
                                        .watch(lotListProvider.notifier);
                                    final value = isEdit
                                        ? await lotNotifier
                                            .updateLot(newlot)
                                        : await lotNotifier
                                            .addLot(newlot);
                                    if (value) {
                                      QR.back();
                                      if (isEdit) {
                                        displayToastWithContext(TypeMsg.msg,
                                            TombolaTextConstants.editedTicket);
                                      } else {
                                        displayToastWithContext(TypeMsg.msg,
                                            TombolaTextConstants.addedTicket);
                                      }
                                    } else {
                                      if (isEdit) {
                                        displayToastWithContext(TypeMsg.error,
                                            TombolaTextConstants.editingError);
                                      } else {
                                        displayToastWithContext(
                                            TypeMsg.error,
                                            TombolaTextConstants
                                                .addingError);
                                      }
                                    }
                                  });
                                } else {
                                  displayToast(context, TypeMsg.error,
                                      TombolaTextConstants.addingError);
                                }
                              },
                              child: BlueBtn(
                                  text: isEdit
                                      ? TombolaTextConstants.editlot
                                      : TombolaTextConstants.addlot)),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    )))),
      ),
    );
  }
}
