import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myecl/tombola/providers/cash_provider.dart';
import 'package:myecl/tombola/providers/lot_list_provider.dart';
import 'package:myecl/tombola/providers/type_ticket_provider.dart';
import 'package:myecl/tombola/tools/constants.dart';
import 'package:myecl/tombola/ui/blue_btn.dart';
import 'package:myecl/tombola/ui/pages/admin_page/account_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_page/ticket_handler.dart';
import 'package:myecl/tombola/ui/pages/admin_page/lot_handler.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.read(cashProvider.notifier);
    final typeTicketsListNotifier = ref.read(typeTicketsListProvider.notifier);
    final lotListNotifier = ref.read(lotListProvider.notifier);

    return Refresher(
        onRefresh: () async {
          await cashNotifier.loadCashList();
          await typeTicketsListNotifier.loadTypeTicketList();
          await lotListNotifier.loadLotList();
        },
        child: Column(
          children: [
            const AccountHandler(),
            const SizedBox(
              height: 12,
            ),
            const TicketHandler(),
            const SizedBox(
              height: 12,
            ),
            const LotHandler(),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ShrinkButton(
                  waitChild: const BlueBtn(text: TombolaTextConstants.waiting),
                  onTap: () async {
                    await tokenExpireWrapper(ref, () async {
                      // final newTypeTicket = typeTicket.copyWith(
                      //     price: int.parse(price.text),
                      //     nbTicket: int.parse(quantity.text));
                      // final typeTicketNotifier =
                      //     ref.watch(typeTicketsListProvider.notifier);
                      // final value = isEdit
                      //     ? await typeTicketNotifier
                      //         .updateTypeTicket(newTypeTicket)
                      //     : await typeTicketNotifier
                      //         .addTypeTicket(newTypeTicket);
                      // if (value) {
                      //   pageNotifier.setTombolaPage(TombolaPage.admin);
                      //     displayToastWithContext(
                      //         TypeMsg.msg, TombolaTextConstants.addedTicket);

                      // } else {
                      //   displayToastWithContext(TypeMsg.error,
                      //         TombolaTextConstants.alreadyExistTicket);

                      // }
                    });
                  },
                  child: const BlueBtn(text: "Ouvrir")),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ));
  }
}
