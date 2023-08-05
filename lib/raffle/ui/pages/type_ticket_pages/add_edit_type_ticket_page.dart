import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/raffle/class/type_ticket_simple.dart';
import 'package:myecl/raffle/providers/raffle_provider.dart';
import 'package:myecl/raffle/providers/ticket_type_provider.dart';
import 'package:myecl/raffle/providers/type_ticket_provider.dart';
import 'package:myecl/raffle/tools/constants.dart';
import 'package:myecl/raffle/ui/components/section_title.dart';
import 'package:myecl/raffle/ui/pages/admin_page/blue_btn.dart';
import 'package:myecl/raffle/ui/raffle.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditTypeTicketSimplePage extends HookConsumerWidget {
  const AddEditTypeTicketSimplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final raffle = ref.watch(raffleProvider);
    final typeTicket = ref.watch(typeTicketProvider);
    final isEdit = typeTicket.id != TypeTicketSimple.empty().id;
    final packSize = useTextEditingController(
        text: isEdit ? typeTicket.packSize.toString() : "");
    final price = useTextEditingController(
        text: isEdit ? typeTicket.price.toString() : "");

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
                          const AlignLeftText(
                            RaffleTextConstants.addTypeTicketSimple,
                            fontSize: 25,
                            color: RaffleColorConstants.gradient1,
                          ),
                          const SizedBox(height: 35),
                          const SectionTitle(
                              text: RaffleTextConstants.ticketNumber),
                          const SizedBox(height: 5),
                          TextEntry(
                              label: RaffleTextConstants.ticketNumber,
                              isInt: true,
                              controller: packSize,
                              keyboardType: TextInputType.number),
                          const SizedBox(height: 50),
                          const SectionTitle(text: RaffleTextConstants.price),
                          const SizedBox(height: 5),
                          TextEntry(
                              label: RaffleTextConstants.price,
                              isDouble: true,
                              suffix: "€",
                              controller: price,
                              keyboardType: TextInputType.number),
                          const SizedBox(height: 50),
                          WaitingButton(
                              builder: (child) => BlueBtn(child: child),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  final ticketPrice = double.tryParse(
                                      price.text.replaceAll(',', '.'));
                                  if (ticketPrice != null && ticketPrice > 0) {
                                    await tokenExpireWrapper(ref, () async {
                                      final newTypeTicketSimple =
                                          typeTicket.copyWith(
                                              price: double.parse(price.text),
                                              packSize:
                                                  int.parse(packSize.text),
                                              raffleId: isEdit
                                                  ? typeTicket.raffleId
                                                  : raffle.id,
                                              id: isEdit ? typeTicket.id : "");
                                      final typeTicketNotifier = ref.watch(
                                          typeTicketsListProvider.notifier);
                                      final value = isEdit
                                          ? await typeTicketNotifier
                                              .updateTypeTicketSimple(
                                                  newTypeTicketSimple)
                                          : await typeTicketNotifier
                                              .addTypeTicketSimple(
                                                  newTypeTicketSimple);
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
                                          displayToastWithContext(
                                              TypeMsg.error,
                                              RaffleTextConstants
                                                  .alreadyExistTicket);
                                        }
                                      }
                                    });
                                  } else {
                                    displayToast(context, TypeMsg.error,
                                        RaffleTextConstants.invalidPrice);
                                  }
                                } else {
                                  displayToast(context, TypeMsg.error,
                                      RaffleTextConstants.addingError);
                                }
                              },
                              child: Text(
                                isEdit
                                    ? RaffleTextConstants.editTypeTicketSimple
                                    : RaffleTextConstants.addTypeTicketSimple,
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