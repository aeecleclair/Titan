import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/class/pack_ticket.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/ticket_type_provider.dart';
import 'package:myecl/tombola/providers/pack_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/blue_btn.dart';
import 'package:myecl/tombola/ui/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditPackTicketPage extends HookConsumerWidget {
  const AddEditPackTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final raffle = ref.watch(raffleProvider);
    final packTicket = ref.watch(packTicketProvider);
    final isEdit = packTicket.id != PackTicket.empty().id;
    final packSize = useTextEditingController(
        text: isEdit ? packTicket.packSize.toString() : "");
    final price = useTextEditingController(
        text: isEdit ? packTicket.price.toString() : "");

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
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            TombolaTextConstants.addTypeTicketSimple,
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
                            child: Text("Nombre de ticket",
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
                            textEditingController: packSize,
                            keyboardType: TextInputType.number),
                        const SizedBox(
                          height: 50,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Prix",
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
                              if (double.tryParse(value) == null) {
                                return TombolaTextConstants.numberExpected;
                              }
                              return null;
                            },
                            suffixText: "€",
                            textEditingController: price,
                            keyboardType: TextInputType.number),
                        const SizedBox(
                          height: 50,
                        ),
                        ShrinkButton(
                            waitChild: const BlueBtn(
                                text: TombolaTextConstants.waiting),
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                final ticketPrice = double.tryParse(
                                    price.text.replaceAll(',', '.'));
                                if (ticketPrice != null && ticketPrice > 0) {
                                  await tokenExpireWrapper(ref, () async {
                                    final newPackTicket = packTicket.copyWith(
                                        price: double.parse(price.text),
                                        packSize: int.parse(packSize.text),
                                        raffleId: isEdit
                                            ? packTicket.raffleId
                                            : raffle.id,
                                        id: isEdit ? packTicket.id : "");
                                    final typeTicketNotifier = ref
                                        .watch(packTicketListProvider.notifier);
                                    final value = isEdit
                                        ? await typeTicketNotifier
                                            .updatePackTicket(newPackTicket)
                                        : await typeTicketNotifier
                                            .addPackTicket(newPackTicket);
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
                                                .alreadyExistTicket);
                                      }
                                    }
                                  });
                                } else {
                                  displayToast(context, TypeMsg.error,
                                      TombolaTextConstants.invalidPrice);
                                }
                              } else {
                                displayToast(context, TypeMsg.error,
                                    TombolaTextConstants.addingError);
                              }
                            },
                            child: BlueBtn(
                                text: isEdit
                                    ? TombolaTextConstants.editTypeTicketSimple
                                    : TombolaTextConstants
                                        .addTypeTicketSimple)),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )))),
    );
  }
}
