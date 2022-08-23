import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/providers/amap_page_provider.dart';
import 'package:myecl/amap/providers/cash_provider.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/green_btn.dart';
import 'package:myecl/amap/ui/pages/solde_page/cash_ui.dart';
import 'package:myecl/amap/ui/refresh_indicator.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

List<Widget> buildAll(AsyncValue<List<Cash>> cashList, editingController) {
  return cashList.when(
    data: (cash) {
      if (cash.isNotEmpty) {
        List<Widget> list = [];
        for (Cash c in cash) {
          list.add(CashUi(c: c, i: cash.indexOf(c)));
        }
        return list;
      } else {
        return [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Text(
                  AMAPTextConstants.usersNotFound,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          )
        ];
      }
    },
    error: (error, s) {
      return [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                error.toString(),
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        )
      ];
    },
    loading: () {
      return [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AMAPColorConstants.textDark,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        )
      ];
    },
  );
}

class SoldePage extends HookConsumerWidget {
  const SoldePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingController = useTextEditingController();
    final cashListNotifier = ref.watch(cashProvider.notifier);
    final pageNotifier = ref.watch(amapPageProvider.notifier);
    final cash = useState(ref.watch(cashProvider));
    final focus = useState(false);
    ref.watch(userList);
    List<Widget> listWidgetCash = buildAll(cash.value, editingController);

    return AmapRefresher(
      onRefresh: () async {
        cash.value = await cashListNotifier.loadCashList();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 90,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    focus.value = true;
                    tokenExpireWrapper(ref, () async {
                      final value = await cashListNotifier
                          .filterCashList(editingController.text);
                      cash.value = value;
                    });
                  },
                  controller: editingController,
                  autofocus: focus.value,
                  decoration: const InputDecoration(
                      labelText: AMAPTextConstants.looking,
                      hintText: AMAPTextConstants.looking,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AMAPColorConstants.background2.withOpacity(0.5)),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listWidgetCash.length,
                        itemBuilder: (context, index) {
                          return listWidgetCash[index];
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        child: const GreenBtn(text: AMAPTextConstants.addUser),
                        onTap: () {
                          pageNotifier.setAmapPage(AmapPage.addSolde);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
