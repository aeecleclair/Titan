import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tricount/providers/sharer_group_provider.dart';
import 'package:myecl/tricount/ui/pages/detail_page/member_card.dart';
import 'package:myecl/tricount/ui/pages/detail_page/sharer_property_list.dart';
import 'package:myecl/tricount/ui/pages/detail_page/transaction_card.dart';
import 'package:myecl/tricount/ui/pages/tricount.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SharerGroupDetailPage extends HookConsumerWidget {
  const SharerGroupDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharerGroup = ref.watch(sharerGroupProvider);
    final pageController = usePageController();

    final pages = [
      SharerPropertyList(
          propertyList: sharerGroup.sharers,
          title: 'Participants',
          builder: (e) => MemberCard(member: e),
          onTap: () {}),
      SharerPropertyList(
          propertyList: sharerGroup.transactions,
          title: 'Transactions',
          builder: (e) => TransactionCard(transaction: e),
          onTap: () {}),
    ];

    return TricountTemplate(
        child: Refresher(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 5))
                  ]),
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
                    height: 700,
                    child: PageView(controller: pageController, children: pages),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
