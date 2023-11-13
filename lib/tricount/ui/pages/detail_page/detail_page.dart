import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tricount/providers/sharer_group_list_provider.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/router.dart';
import 'package:myecl/tricount/tools/functions.dart';
import 'package:myecl/tricount/ui/pages/components/equilibrium_card.dart';
import 'package:myecl/tricount/ui/pages/detail_page/balance_card.dart';
import 'package:myecl/tricount/ui/pages/detail_page/bottom_button.dart';
import 'package:myecl/tricount/ui/pages/detail_page/member_card.dart';
import 'package:myecl/tricount/ui/pages/detail_page/sharer_property_list.dart';
import 'package:myecl/tricount/ui/pages/detail_page/transaction_card.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SharerGroupDetailPage extends HookConsumerWidget {
  const SharerGroupDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroup = ref.watch(sharerGroupProvider);
    final sharerGroupListNotifier = ref.watch(sharerGroupListProvider.notifier);
    final pageController = usePageController();
    final me = ref.watch(userProvider);

    final allUsersBalance = getAllUserBalanceTransactions(
        sharerGroup.balances, sharerGroup.members);
    final maxAbsBalance = allUsersBalance.fold(
        0.0, (value, element) => max(value, element.amount.abs()));
    final currentPage = useState(0);

    final myBalance =
        allUsersBalance.firstWhereOrNull((element) => element.payer == me.id);

    final pages = [
      SharerPropertyList(
          propertyList: allUsersBalance,
          title: 'Résumé',
          builder: (e) => BalanceCard(
              transaction: e,
              members:  sharerGroup.members,
              maxAbsBalance: maxAbsBalance,
              isMe: e.payer == me.id)),
      SharerPropertyList(
          propertyList: sharerGroup.transactions,
          title: 'Dépenses',
          builder: (e) => TransactionCard(
                transaction: e,
                members: sharerGroup.members,
              )),
      SharerPropertyList(
          propertyList: sharerGroup.balances,
          title: 'Remboursements',
          builder: (e) => EquilibriumCard(
              balance: e, members: sharerGroup.members, isLightTheme: true)),
      SharerPropertyList(
          propertyList: sharerGroup.members,
          title: 'Participants',
          builder: (e) => MemberCard(member: e))
    ];

    final buttonStates = [
      ButtonState(
          text: 'Modifier le groupe',
          onTap: () {
            QR.to(TricountRouter.root + TricountRouter.addEdit);
          }),
      ButtonState(text: 'Ajouter une dépense', onTap: () {}),
      ButtonState(text: 'Rembourser', onTap: () {}),
      ButtonState(
          text: 'Quitter le groupe',
          onTap: () {},
          disabled: myBalance == null || myBalance.amount != 0),
    ];

    pageController
        .addListener(() => currentPage.value = pageController.page!.round());

    return TricountTemplate(
        child: Refresher(
      onRefresh: () async {},
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 80,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    sharerGroup.name,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff09263D)),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: max(
                        MediaQuery.of(context).size.height - 380,
                        max(
                                    max(sharerGroup.balances.length,
                                        sharerGroup.members.length),
                                    sharerGroup.transactions.length) *
                                80 +
                            80),
                    child: PageView(
                        physics: const BouncingScrollPhysics(),
                        controller: pageController,
                        children: pages),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: pages.length,
                  effect: WormEffect(
                      dotColor: Colors.grey.shade300,
                      activeDotColor: const Color(0xff09263D),
                      dotWidth: 12,
                      dotHeight: 12),
                  onDotClicked: (index) {
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate);
                  },
                ),
                const SizedBox(height: 20),
                BottomButton(buttonState: buttonStates[currentPage.value])
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
