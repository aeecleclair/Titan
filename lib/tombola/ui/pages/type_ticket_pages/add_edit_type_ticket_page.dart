import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/class/type_ticket_simple.dart';
import 'package:myecl/tombola/providers/raffle_provider.dart';
import 'package:myecl/tombola/providers/ticket_type_provider.dart';
import 'package:myecl/tombola/providers/tombola_page_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/blue_btn.dart';
import 'package:myecl/tombola/ui/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AddEditTypeTicketSimplePage extends HookConsumerWidget {
  const AddEditTypeTicketSimplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final raffle = ref.watch(raffleProvider);
    final pageNotifier = ref.watch(tombolaPageProvider.notifier);
    final typeTicket = ref.watch(typeTicketProvider);
    final isEdit = typeTicket.id != TypeTicketSimple.empty().id;
    final quantity = useTextEditingController(
        text: isEdit ? typeTicket.value.toString() : "");
    final price = useTextEditingController(
        text: isEdit ? typeTicket.price.toString() : "");

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
                              return null;
                            },
                            textEditingController: quantity,
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
                              if (int.tryParse(value) == null) {
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
                                await tokenExpireWrapper(ref, () async {
                                  final newTypeTicketSimple = typeTicket.copyWith(
                                      price: double.parse(price.text),
                                      value: int.parse(quantity.text),
                                      raffleId: isEdit
                                          ? typeTicket.raffleId
                                          : raffle.id,
                                      id: isEdit ? typeTicket.id : "");
                                  final typeTicketNotifier = ref
                                      .watch(typeTicketsListProvider.notifier);
                                  final value = isEdit
                                      ? await typeTicketNotifier
                                          .updateTypeTicketSimple(newTypeTicketSimple)
                                      : await typeTicketNotifier
                                          .addTypeTicketSimple(newTypeTicketSimple);
                                  if (value) {
                                    pageNotifier
                                        .setTombolaPage(TombolaPage.admin);
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
                                    TombolaTextConstants.addingError);
                              }
                            },
                            child: BlueBtn(
                                text: isEdit
                                    ? TombolaTextConstants.editTypeTicketSimple
                                    : TombolaTextConstants.addTypeTicketSimple)),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )))),
    );
  }
}
