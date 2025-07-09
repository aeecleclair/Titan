import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/raffle/class/pack_ticket.dart';
import 'package:titan/raffle/providers/pack_ticket_provider.dart';
import 'package:titan/raffle/providers/raffle_provider.dart';
import 'package:titan/raffle/providers/pack_ticket_list_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/components/blue_btn.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AddEditPackTicketPage extends HookConsumerWidget {
  const AddEditPackTicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final raffle = ref.watch(raffleProvider);
    final packTicket = ref.watch(packTicketProvider);
    final isEdit = packTicket.id != PackTicket.empty().id;
    final packSize = useTextEditingController(
      text: isEdit ? packTicket.packSize.toString() : "",
    );
    final price = useTextEditingController(
      text: isEdit ? packTicket.price.toString() : "",
    );

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
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.raffleAddTypeTicketSimple,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: RaffleColorConstants.gradient1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nombre de ticket",
                      style: TextStyle(
                        color: RaffleColorConstants.gradient2,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextEntry(
                    label: "Nombre de ticket",
                    isInt: true,
                    validator: (value) {
                      if (int.parse(value) < 1) {
                        return AppLocalizations.of(
                          context,
                        )!.raffleMustBePositive;
                      }
                      return null;
                    },
                    controller: packSize,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Prix",
                      style: TextStyle(
                        color: RaffleColorConstants.gradient2,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextEntry(
                    label: "Prix",
                    isDouble: true,
                    suffix: "€",
                    controller: price,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 50),
                  WaitingButton(
                    builder: (child) => BlueBtn(child: child),
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        final ticketPrice = double.tryParse(
                          price.text.replaceAll(',', '.'),
                        );
                        if (ticketPrice != null && ticketPrice > 0) {
                          await tokenExpireWrapper(ref, () async {
                            final newPackTicket = packTicket.copyWith(
                              price: double.parse(price.text),
                              packSize: int.parse(packSize.text),
                              raffleId: isEdit
                                  ? packTicket.raffleId
                                  : raffle.id,
                              id: isEdit ? packTicket.id : "",
                            );
                            final typeTicketNotifier = ref.watch(
                              packTicketListProvider.notifier,
                            );
                            final editedTicketMsg = isEdit
                                ? AppLocalizations.of(
                                    context,
                                  )!.raffleEditedTicket
                                : AppLocalizations.of(
                                    context,
                                  )!.raffleAddedTicket;
                            final addingErrorMsg = isEdit
                                ? AppLocalizations.of(
                                    context,
                                  )!.raffleEditingError
                                : AppLocalizations.of(
                                    context,
                                  )!.raffleAddingError;
                            final value = isEdit
                                ? await typeTicketNotifier.updatePackTicket(
                                    newPackTicket,
                                  )
                                : await typeTicketNotifier.addPackTicket(
                                    newPackTicket,
                                  );
                            if (value) {
                              QR.back();
                              displayToastWithContext(
                                TypeMsg.msg,
                                editedTicketMsg,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                addingErrorMsg,
                              );
                            }
                          });
                        } else {
                          displayToast(
                            context,
                            TypeMsg.error,
                            AppLocalizations.of(context)!.raffleInvalidPrice,
                          );
                        }
                      } else {
                        displayToast(
                          context,
                          TypeMsg.error,
                          AppLocalizations.of(context)!.raffleAddingError,
                        );
                      }
                    },
                    child: Text(
                      isEdit
                          ? AppLocalizations.of(
                              context,
                            )!.raffleEditTypeTicketSimple
                          : AppLocalizations.of(
                              context,
                            )!.raffleAddTypeTicketSimple,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
