import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddLoanerPage extends HookConsumerWidget {
  const AddLoanerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final loanerListNotifier = ref.watch(loanerListProvider.notifier);
    final loaners = ref.watch(loanerList);
    final associations = ref.watch(allGroupListProvider);
    final loanersId = loaners.map((x) => x.groupManagerId).toList();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            children: [
              SizedBox(
                  child: Column(children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AdminTextConstants.addLoaningAssociation,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1)),
                ),
                const SizedBox(
                  height: 30,
                ),
                associations.when(data: (associationList) {
                  final canAdd = associationList
                      .where((x) => !loanersId.contains(x.id))
                      .toList();
                  return canAdd.isNotEmpty
                      ? Column(
                          children: canAdd
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      Loaner newLoaner = Loaner(
                                          groupManagerId: e.id,
                                          id: '',
                                          name: e.name);
                                      tokenExpireWrapper(ref, () async {
                                        final value = await loanerListNotifier
                                            .addLoaner(newLoaner);
                                        if (value) {
                                          pageNotifier
                                              .setAdminPage(AdminPage.main);
                                          displayToastWithContext(TypeMsg.msg,
                                              AdminTextConstants.addedLoaner);
                                        } else {
                                          displayToastWithContext(TypeMsg.error,
                                              AdminTextConstants.addingError);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            capitalize(e.name),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary),
                                          ),
                                          HeroIcon(HeroIcons.plus,
                                              size: 25,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary)
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList())
                      : const Center(
                          child: Text(AdminTextConstants.noMoreLoaner));
                }, error: (Object error, StackTrace? stackTrace) {
                  return Text(error.toString());
                }, loading: () {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ));
                })
              ]))
            ],
          ),
        ));
  }
}
