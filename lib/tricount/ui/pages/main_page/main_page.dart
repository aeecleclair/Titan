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
    final currentPage = useState(0);
    const viewPortFraction = 0.85;
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
            builder: (context, sharerGroupList) {
              final pageController = usePageController(
                  viewportFraction: viewPortFraction,
                  initialPage: sharerGroupList.length - 1);
              final fakePageController = usePageController(
                  viewportFraction: viewPortFraction,
                  initialPage: sharerGroupList.length - 1);
              pageController.addListener(() {
                fakePageController.jumpTo(pageController.offset);
              });
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Column(children: [
                        Transform(
                          alignment: AlignmentGeometry.lerp(
                              AlignmentGeometry.lerp(
                                  Alignment.topLeft,
                                  Alignment.bottomLeft,
                                  0.5 - scrollValue.value / 500 * 0.8),
                              AlignmentGeometry.lerp(
                                  Alignment.topRight,
                                  Alignment.bottomRight,
                                  0.5 - scrollValue.value / 500 * 0.8),
                              0.5)!,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..scale(min(
                                1.0, max(1 - scrollValue.value / 500, 0.5))),
                          child: Opacity(
                              opacity:
                                  min(1.0, max(1 - scrollValue.value / 500, 0)),
                              child: SharerGroupHandler(
                                  sharerGroups: sharerGroupList,
                                  pageController: fakePageController,
                                  viewPortFraction: viewPortFraction)),
                        ),
                        SizedBox(height: max(0, 350 - scrollValue.value)),
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              color: const Color(0xff09263D)),
                        ),
                      ]),
                    ),
                    Positioned.fill(
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: PageView(
                                    physics: const BouncingScrollPhysics(),
                                    clipBehavior: Clip.none,
                                    controller: pageController,
                                    reverse: true,
                                    onPageChanged: (index) {
                                      currentPage.value =
                                          sharerGroupList.length - 1 - index;
                                    },
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 45, horizontal: 10),
                                          child: GestureDetector(onTap: () {})),
                                      ...sharerGroupList.map((e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 45, horizontal: 10),
                                          child: GestureDetector(onTap: () {
                                            final index =
                                                sharerGroupList.indexOf(e);
                                            print(index);
                                          })))
                                    ]),
                              ),
                              SharerGroupStats(
                                equilibriumTransactions: currentPage.value >= 0
                                    ? sharerGroupList[currentPage.value]
                                        .equilibriumTransactions
                                    : [],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
