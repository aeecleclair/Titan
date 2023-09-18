import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/all_loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/align_left_text.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddLoanerPage extends HookConsumerWidget {
  const AddLoanerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanerListNotifier = ref.watch(loanerListProvider.notifier);
    final loaners = ref.watch(allLoanerList);
    final associations = ref.watch(allGroupListProvider);
    final loanersId = loaners.map((x) => x.groupManagerId).toList();
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                SizedBox(
                    child: Column(children: [
                  const AlignLeftText(AdminTextConstants.addLoaningAssociation),
                  const SizedBox(height: 30),
                  associations.when(
                      data: (associationList) {
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
                                              final value =
                                                  await loanerListNotifier
                                                      .addLoaner(newLoaner);
                                              if (value) {
                                                QR.back();
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    AdminTextConstants
                                                        .addedLoaner);
                                              } else {
                                                displayToastWithContext(
                                                    TypeMsg.error,
                                                    AdminTextConstants
                                                        .addingError);
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  e.name,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const HeroIcon(HeroIcons.plus,
                                                    size: 25,
                                                    color: Colors.black)
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList())
                            : const Center(
                                child: Text(AdminTextConstants.noMoreLoaner));
                      },
                      error: (Object error, StackTrace? stackTrace) =>
                          Text(error.toString()),
                      loading: () => const Loader())
                ]))
              ],
            ),
          )),
    );
  }
}
