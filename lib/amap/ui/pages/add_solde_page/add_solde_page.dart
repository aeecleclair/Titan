import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/amap/ui/pages/add_solde_page/search_result.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddSoldePage extends HookConsumerWidget {
  const AddSoldePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersNotifier = ref.watch(userList.notifier);
    final editingController = useTextEditingController();

    return Refresher(
      onRefresh: () async {
        usersNotifier.clear();
      },
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
                tokenExpireWrapper(ref, () async {
                  if (editingController.text.isNotEmpty) {
                    await usersNotifier.filterUsers(editingController.text);
                  } else {
                    usersNotifier.clear();
                  }
                });
              },
              controller: editingController,
              decoration: const InputDecoration(
                  labelText: AMAPTextConstants.looking,
                  hintText: AMAPTextConstants.looking,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SearchResult()
        ]),
      ),
    );
  }
}
