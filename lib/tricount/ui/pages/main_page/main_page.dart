import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
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
    final scrollController = useScrollController();
    final scrollValue = useState<double>(0);
    scrollController.addListener(() {
      scrollValue.value = scrollController.offset;
    });
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
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onVerticalDragUpdate: (details) {
                        scrollController
                            .jumpTo(scrollController.offset - details.delta.dy);
                      },
                      child: Column(children: [
                        Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..scale(max(1 - scrollValue.value / 500, 0.5)),
                          child: Opacity(
                              opacity:
                                  min(1, max(1 - scrollValue.value / 500, 0)),
                              child: SharerGroupHandler(
                                  sharerGroups: sharerGroupList)),
                        ),
                        SizedBox(height: max(0, 350 - scrollValue.value)),
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              color: const Color(0xff09263D)),
                        ),
                      ]),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                        ignoring: true,
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            child: Column(
                              children: [
                                const SizedBox(height: 300),
                                SharerGroupStats(
                                  equilibriumTransactions: sharerGroupList[0]
                                      .equilibriumTransactions,
                                ),
                              ],
                            ))),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
