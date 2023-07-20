import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/raffle/class/prize.dart';
import 'package:myecl/raffle/providers/prize_list_provider.dart';
import 'package:myecl/raffle/providers/prize_provider.dart';
import 'package:myecl/raffle/providers/raffle_provider.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/components/section_title.dart';
import 'package:myecl/raffle/ui/pages/admin_page/blue_btn.dart';
import 'package:myecl/raffle/ui/raffle.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/tools/ui/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditPrizePage extends HookConsumerWidget {
  const AddEditPrizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final raffle = ref.watch(raffleProvider);
    final prize = ref.watch(prizeProvider);
    final isEdit = prize.id != Prize.empty().id;
    final quantity = useTextEditingController(
        text: isEdit ? prize.quantity.toString() : "1");
    final name = useTextEditingController(text: prize.name);
    final description = useTextEditingController(text: prize.description);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return RaffleTemplate(
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
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              RaffleTextConstants.addPrize,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 25,
                                color: RaffleColorConstants.gradient1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          const SectionTitle(text: "Quantité"),
                          const SizedBox(height: 5),
                          TextEntry(
                              label: "Quantité",
                              isInt: true,
                              controller: quantity,
                              keyboardType: TextInputType.number),
                          const SizedBox(height: 50),
                          const SectionTitle(text: "Nom"),
                          const SizedBox(height: 5),
                          TextEntry(
                              label: "Nom",
                              controller: name,
                              keyboardType: TextInputType.text),
                          const SizedBox(height: 50),
                          const SectionTitle(text: "Description"),
                          const SizedBox(height: 5),
                          TextEntry(
                              label: "Description",
                              canBeEmpty: true,
                              controller: description,
                              keyboardType: TextInputType.text),
                          const SizedBox(height: 50),
                          ShrinkButton(
                              builder: (child) => BlueBtn(
                                    child: child,
                                  ),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await tokenExpireWrapper(ref, () async {
                                    final newPrize = prize.copyWith(
                                        name: name.text,
                                        description: description.text,
                                        raffleId:
                                            isEdit ? prize.raffleId : raffle.id,
                                        quantity: int.parse(quantity.text));
                                    final prizeNotifier =
                                        ref.watch(prizeListProvider.notifier);
                                    final value = isEdit
                                        ? await prizeNotifier
                                            .updatePrize(newPrize)
                                        : await prizeNotifier
                                            .addPrize(newPrize);
                                    if (value) {
                                      QR.back();
                                      if (isEdit) {
                                        displayToastWithContext(TypeMsg.msg,
                                            RaffleTextConstants.editedTicket);
                                      } else {
                                        displayToastWithContext(TypeMsg.msg,
                                            RaffleTextConstants.addedTicket);
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
                              child: Text(
                                isEdit
                                    ? RaffleTextConstants.editPrize
                                    : RaffleTextConstants.addPrize,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: RaffleColorConstants.gradient2),
                              )),
                          const SizedBox(height: 40),
                        ],
                      ),
                    )))),
      ),
    );
  }
}
