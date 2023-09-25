import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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
      child: RefreshIndicator(
          onRefresh: () => tokenExpireWrapper(ref, () async {
                sharerGroupListNotifier.loadSharerGroupList();
              }),
          child: AsyncChild(
            value: sharerGroupList,
            builder: (context, sharerGroupList) => SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(children: [
                      SharerGroupHandler(sharerGroups: sharerGroupList),
                      const SizedBox(height: 150),
                      Expanded(
                        child: Container(
                            width: double.infinity, color: const Color(0xff09263D)),
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 300),
                          SharerGroupStats(
                            equilibriumTransactions:
                                sharerGroupList[0].equilibriumTransactions,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
