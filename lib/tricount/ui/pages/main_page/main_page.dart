import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/class/sharer_group_membership.dart';
import 'package:myecl/tricount/providers/cross_group_stats_provider.dart';
import 'package:myecl/tricount/providers/membership_list_provider.dart';
import 'package:myecl/tricount/providers/membership_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_member_list_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/router.dart';
import 'package:myecl/tricount/ui/pages/main_page/sharer_group_handler.dart';
import 'package:myecl/tricount/ui/pages/main_page/sharer_group_stats.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TricountMainPage extends HookConsumerWidget {
  const TricountMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroupMembership =
        ref.watch(sharerGroupMembershipProvider.notifier);
    final membershipList = ref.watch(membershipListProvider);
    final membershipListNotifier = ref.watch(membershipListProvider.notifier);
    // final myBalances = ref.watch(crossGroupStatsProvider);
    final sharerGroupMemberListNotifier =
        ref.watch(sharerGroupMemberListProvider.notifier);
    final scrollController = useScrollController();
    final scrollValue = useState<double>(0);
    final currentPage = useState(0);
    const viewPortFraction = 0.85;
    scrollController.addListener(() {
      scrollValue.value = scrollController.offset;
    });

    return TricountTemplate(
      // We don't use Refresher because it doesn't work with the stacked PageView and SingleChildScrollView
      child: RefreshIndicator(
          onRefresh: () => tokenExpireWrapper(ref, () async {
                membershipListNotifier.loadMembership();
              }),
          child: AsyncChild(
            value: membershipList,
            builder: (context, memberships) {
              // final ids = <String>{};
              // final allMembersList = sharerGroupList
              //     .expand((sharerGroup) => sharerGroup.members)
              //     .where((member) {
              //   if (!ids.contains(member.id)) {
              //     ids.add(member.id);
              //     return true;
              //   }
              //   return false;
              // }).toList();
              final pageController = usePageController(
                  viewportFraction: viewPortFraction,
                  initialPage: memberships.length);
              final fakePageController = usePageController(
                  viewportFraction: viewPortFraction,
                  initialPage: memberships.length);
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
                                  memberships: memberships,
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
                                child: PageView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    clipBehavior: Clip.none,
                                    controller: pageController,
                                    itemCount: memberships.length + 1,
                                    reverse: true,
                                    onPageChanged: (index) {
                                      currentPage.value =
                                          memberships.length - 1 - index;
                                    },
                                    itemBuilder: (context, index) {
                                      if (index == memberships.length) {
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 45, horizontal: 10),
                                            child: GestureDetector(onTap: () {
                                              sharerGroupMembership.set(
                                                  SharerGroupMembership
                                                      .empty());
                                              sharerGroupMemberListNotifier
                                                  .reset();
                                              QR.to(TricountRouter.root +
                                                  TricountRouter.addEdit);
                                            }));
                                      }
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 45, horizontal: 10),
                                          child: GestureDetector(onTap: () {
                                            final membership = memberships[
                                                memberships.length - 1 - index];
                                            sharerGroupMembership
                                                .set(membership);
                                            QR.to(TricountRouter.root +
                                                TricountRouter.detail);
                                          }));
                                    }),
                              ),
                              // SharerGroupStats(
                              //   balances: currentPage.value >= 0
                              //       ? memberships[currentPage.value]
                              //           .balances
                              //           .where((element) => element.amount < 0)
                              //           .toList()
                              //       : myBalances,
                              //   members: currentPage.value >= 0
                              //       ? sharerGroupList[currentPage.value].members
                              //       : allMembersList,
                              // ),
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
