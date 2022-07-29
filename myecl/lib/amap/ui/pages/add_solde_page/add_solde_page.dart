import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddSoldePage extends HookConsumerWidget {
  const AddSoldePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userList);
    final cashListNotifier = ref.watch(cashProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    return users.when(data: (u) {
      return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            ...u
                .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            e.firstname +
                                " " +
                                e.name +
                                (e.nickname.isNotEmpty
                                    ? " (" + e.nickname + ")"
                                    : ""),
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  cashListNotifier
                                      .addCash(Cash(balance: 0.0, user: e))
                                      .then((value) {
                                    if (value) {
                                      displayToast(context, TypeMsg.msg,
                                          "Utilisateur ajouté");
                                    } else {
                                      displayToast(context, TypeMsg.error,
                                          "Erreur lors de l'ajout");
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
          ]));
    }, error: (e, s) {
      return const Text("Aucun utilisateur trouvé");
    }, loading: () {
      return const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.gradient2),
      ));
    });
  }
}
