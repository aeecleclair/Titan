import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/providers/settings_page_provider.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class AddLoanerPage extends HookConsumerWidget {
  const AddLoanerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(adminPageProvider.notifier);
    final loanerListNotifier = ref.watch(loanerListProvider.notifier);
    final loaners = ref.watch(loanerList);
    final associations = ref.watch(allGroupListProvider);
    final loanersId = loaners.map((x) => x.groupManagerId).toList();
    return associations.when(data: (associationList) {
      final canAdd =
          associationList.where((x) => !loanersId.contains(x.id)).toList();
      return canAdd.isNotEmpty
          ? Column(
              children: canAdd
                  .map((e) => GestureDetector(
                        onTap: () {
                          Loaner newLoaner = Loaner(
                              groupManagerId: e.id, id: '', name: e.name);
                          tokenExpireWrapper(ref, () async {
                            final value =
                                await loanerListNotifier.addLoaner(newLoaner);
                            if (value) {
                              pageNotifier.setAdminPage(AdminPage.main);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                capitalize(e.name),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              const HeroIcon(HeroIcons.plus,
                                  size: 25, color: Colors.black)
                            ],
                          ),
                        ),
                      ))
                  .toList())
          : const Center(child: Text('No more loaners to add'));
    }, error: (Object error, StackTrace? stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.blue),
      ));
    });
  }
}
