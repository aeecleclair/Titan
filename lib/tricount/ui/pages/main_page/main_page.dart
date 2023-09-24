import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tricount/providers/sharer_group_list_provider.dart';
import 'package:myecl/tricount/ui/pages/main_page/sharer_group_handler.dart';
import 'package:myecl/tricount/ui/pages/main_page/sharer_group_stats.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';

class TricountMainPage extends HookConsumerWidget {
  const TricountMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroupList = ref.watch(sharerGroupListProvider);
    final sharerGroupListNotifier = ref.watch(sharerGroupListProvider.notifier);
    return TricountTemplate(
      child: Refresher(
          onRefresh: () async {
            sharerGroupListNotifier.loadSharerGroupList();
          },
          child: AsyncChild(
            value: sharerGroupList,
            builder: (context, sharerGroupList) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SharerGroupHandler(sharerGroups: sharerGroupList),
                  SharerGroupStats(
                    equilibriumTransactions:
                        sharerGroupList[0].equilibriumTransactions,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
