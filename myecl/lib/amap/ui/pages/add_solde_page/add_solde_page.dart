import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/amap/ui/refresh_indicator.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddSoldePage extends HookConsumerWidget {
  const AddSoldePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = useState(ref.watch(userList));
    final usersNotifier = ref.watch(userList.notifier);
    final cashListNotifier = ref.watch(cashProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final editingController = useTextEditingController();
    final focus = useState(false);
    return Refresh(
        keyRefresh: GlobalKey<RefreshIndicatorState>(),
        onRefresh: () async {
          usersNotifier.loadUserList();
        },
        child: users.value.when(data: (u) {
          return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 90,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        focus.value = true;
                        usersNotifier
                            .filterUsers(editingController.text)
                            .then((value) {
                          users.value = value;
                        });
                      },
                      controller: editingController,
                      autofocus: focus.value,
                      decoration: const InputDecoration(
                          labelText: "Rechercher",
                          hintText: "Rechercher",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
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
                                        tokenExpireWrapper(ref, () {
                                          cashListNotifier
                                              .addCash(
                                                  Cash(balance: 0.0, user: e))
                                              .then((value) {
                                            if (value) {
                                              displayToast(context, TypeMsg.msg,
                                                  "Utilisateur ajouté");
                                            } else {
                                              displayToast(
                                                  context,
                                                  TypeMsg.error,
                                                  "Erreur lors de l'ajout");
                                            }
                                            pageNotifier
                                                .setAmapPage(AmapPage.solde);
                                          });
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
                ]),
              ));
        }, error: (e, s) {
          return const Text("Aucun utilisateur trouvé");
        }, loading: () {
          return const Center(
              child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(AMAPColorConstants.gradient2),
          ));
        }));
  }
}
