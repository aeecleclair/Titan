import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:titan/raffle/class/prize.dart';
import 'package:titan/raffle/providers/prize_list_provider.dart';
import 'package:titan/raffle/providers/prize_provider.dart';
import 'package:titan/raffle/providers/raffle_provider.dart';
import 'package:titan/raffle/tools/constants.dart';
import 'package:titan/raffle/ui/components/blue_btn.dart';
import 'package:titan/raffle/ui/components/section_title.dart';
import 'package:titan/raffle/ui/raffle.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AddEditPrizePage extends HookConsumerWidget {
  const AddEditPrizePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final raffle = ref.watch(raffleProvider);
    final prize = ref.watch(prizeProvider);
    final isEdit = prize.id != Prize.empty().id;
    final quantity = useTextEditingController(
      text: isEdit ? prize.quantity.toString() : "1",
    );
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
                    AlignLeftText(
                      AppLocalizations.of(context)!.raffleAddPrize,
                      fontSize: 25,
                      color: RaffleColorConstants.gradient1,
                    ),
                    const SizedBox(height: 35),
                    SectionTitle(
                      text: AppLocalizations.of(context)!.raffleQuantity,
                    ),
                    const SizedBox(height: 5),
                    TextEntry(
                      label: AppLocalizations.of(context)!.raffleQuantity,
                      isInt: true,
                      controller: quantity,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 50),
                    SectionTitle(
                      text: AppLocalizations.of(context)!.raffleName,
                    ),
                    const SizedBox(height: 5),
                    TextEntry(
                      label: AppLocalizations.of(context)!.raffleName,
                      controller: name,
                    ),
                    const SizedBox(height: 50),
                    SectionTitle(
                      text: AppLocalizations.of(context)!.raffleDescription,
                    ),
                    const SizedBox(height: 5),
                    TextEntry(
                      label: AppLocalizations.of(context)!.raffleDescription,
                      canBeEmpty: true,
                      controller: description,
                    ),
                    const SizedBox(height: 50),
                    WaitingButton(
                      builder: (child) => BlueBtn(child: child),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await tokenExpireWrapper(ref, () async {
                            final newPrize = prize.copyWith(
                              name: name.text,
                              description: description.text,
                              raffleId: isEdit ? prize.raffleId : raffle.id,
                              quantity: int.parse(quantity.text),
                            );
                            final prizeNotifier = ref.watch(
                              prizeListProvider.notifier,
                            );
                            final editedTicket = isEdit
                                ? AppLocalizations.of(
                                    context,
                                  )!.raffleEditedTicket
                                : AppLocalizations.of(
                                    context,
                                  )!.raffleAddedTicket;
                            final addingError = isEdit
                                ? AppLocalizations.of(
                                    context,
                                  )!.raffleEditingError
                                : AppLocalizations.of(
                                    context,
                                  )!.raffleAddingError;
                            final value = isEdit
                                ? await prizeNotifier.updatePrize(newPrize)
                                : await prizeNotifier.addPrize(newPrize);
                            if (value) {
                              QR.back();
                              displayToastWithContext(
                                TypeMsg.msg,
                                editedTicket,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                addingError,
                              );
                            }
                          });
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
                            ? AppLocalizations.of(context)!.raffleEditPrize
                            : AppLocalizations.of(context)!.raffleAddPrize,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: RaffleColorConstants.gradient2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
