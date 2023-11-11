import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/tools/functions.dart';
import 'package:myecl/tricount/ui/pages/components/equilibrium_card.dart';
import 'package:myecl/tricount/ui/pages/detail_page/balance_card.dart';
import 'package:myecl/tricount/ui/pages/detail_page/member_card.dart';
import 'package:myecl/tricount/ui/pages/detail_page/sharer_property_list.dart';
import 'package:myecl/tricount/ui/pages/detail_page/transaction_card.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SharerGroupDetailPage extends HookConsumerWidget {
  const SharerGroupDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroup = ref.watch(sharerGroupProvider);
    final pageController = usePageController();
    final me = ref.watch(userProvider);

    final allUsersBalance = getAllUserBalanceTransactions(
        sharerGroup.equilibriumTransactions, sharerGroup.sharers);
    final maxAbsBalance = allUsersBalance.fold(
        0.0, (value, element) => max(value, element.amount.abs()));

    final pages = [
      SharerPropertyList(
          propertyList: allUsersBalance,
          title: 'Résumé',
          builder: (e) => BalanceCard(
              transaction: e,
              maxAbsBalance: maxAbsBalance,
              isMe: e.payer.id == me.id),
          onTap: null),
      SharerPropertyList(
          propertyList: sharerGroup.transactions,
          title: 'Dépenses',
          builder: (e) => TransactionCard(transaction: e),
          onTap: () {}),
      SharerPropertyList(
          propertyList: sharerGroup.equilibriumTransactions,
          title: 'Remboursements',
          builder: (e) =>
              EquilibriumCard(equilibriumTransaction: e, isLightTheme: true),
          onTap: null),
      SharerPropertyList(
          propertyList: sharerGroup.sharers,
          title: 'Participants',
          builder: (e) => MemberCard(member: e),
          onTap: () {}),
    ];

    return TricountTemplate(
        child: Refresher(
      onRefresh: () async {},
      child: SingleChildScrollView(
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
            SizedBox(
              height: max(
                  MediaQuery.of(context).size.height - 380,
                  max(
                              max(sharerGroup.equilibriumTransactions.length,
                                  sharerGroup.sharers.length),
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
    ));
  }
}
