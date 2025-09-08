import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/admin.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/loan/providers/all_loaner_list_provider.dart';
import 'package:titan/loan/providers/loaner_list_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
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
                child: Column(
                  children: [
                    const AlignLeftText(AdminTextConstants.addLoaningGroup),
                    const SizedBox(height: 30),
                    AsyncChild(
                      value: associations,
                      builder: (context, associationList) {
                        final canAdd = associationList
                            .where((x) => !loanersId.contains(x.id))
                            .toList();
                        return canAdd.isNotEmpty
                            ? Column(
                                children: canAdd
                                    .map(
                                      (e) => GestureDetector(
                                        onTap: () {
                                          Loaner newLoaner = Loaner(
                                            groupManagerId: e.id,
                                            id: '',
                                            name: e.name,
                                          );
                                          tokenExpireWrapper(ref, () async {
                                            final value =
                                                await loanerListNotifier
                                                    .addLoaner(newLoaner);
                                            if (value) {
                                              QR.back();
                                              displayToastWithContext(
                                                TypeMsg.msg,
                                                AdminTextConstants.addedLoaner,
                                              );
                                            } else {
                                              displayToastWithContext(
                                                TypeMsg.error,
                                                AdminTextConstants.addingError,
                                              );
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e.name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const HeroIcon(
                                                HeroIcons.plus,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            : const Center(
                                child: Text(AdminTextConstants.noMoreLoaner),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
