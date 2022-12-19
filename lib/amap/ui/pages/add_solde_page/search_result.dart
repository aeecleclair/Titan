import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class SearchResult extends HookConsumerWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final cashListNotifier = ref.watch(cashProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return users.when(
      data: (u) {
        return Container(
          decoration: BoxDecoration(
              color: AMAPColorConstants.background2.withOpacity(0.5)),
          child: Column(
            children: u
                .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            e.getName(),
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  tokenExpireWrapper(ref, () async {
                                    final value = await cashListNotifier
                                        .addCash(Cash(balance: 0.0, user: e));
                                    if (value) {
                                      displayToastWithContext(TypeMsg.msg,
                                          AMAPTextConstants.addedUser);
                                    } else {
                                      displayToastWithContext(TypeMsg.error,
                                          AMAPTextConstants.addingError);
                                    }
                                    pageNotifier.setAmapPage(AmapPage.solde);
                                  });
                                },
                                icon: const Icon(Icons.add))
                          ],
                        ),
                        Container(
                          width: 15,
                        ),
                      ],
                    ))
                .toList(),
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return const Center(
          child: Text(AMAPTextConstants.errorLoadingUser),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
