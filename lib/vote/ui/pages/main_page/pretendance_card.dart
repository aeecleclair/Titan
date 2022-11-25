import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/selected_pretendance_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/tools/constants.dart';

class PretendanceCard extends HookConsumerWidget {
  final Pretendance pretendance;
  final AnimationController animation;
  final int index;
  const PretendanceCard(
      {super.key,
      required this.pretendance,
      required this.animation,
      required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final pretendanceNotifier=  ref.watch(pretendanceProvider.notifier);
    final section = ref.watch(sectionProvider);
    final sections = ref.watch(sectionsProvider);
    final selectedPretendanceList = ref.watch(selectedPretendanceProvider);
    final selectedPretendanceListNotifier =
        ref.watch(selectedPretendanceProvider.notifier);
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(
          parent: animation,
          curve: Interval(0.05 + 0.05 * index, 0.25 + 0.05 * index,
              curve: Curves.easeOut))),
      child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(bottom: 15, left: 10),
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeroIcon(
                      HeroIcons.cubeTransparent,
                      color: Colors.grey.shade500,
                      size: 30,
                    ),
                    Column(
                      children: [
                        Text(pretendance.name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(
                            capitalize(pretendance.listType
                                .toString()
                                .split('.')
                                .last),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        pretendanceNotifier.setId(pretendance);
                        pageNotifier.setVotePage(VotePage.detailPageFromMain);
                      },
                      child: HeroIcon(
                        HeroIcons.informationCircle,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(pretendance.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400)),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !selectedPretendanceList.contains(pretendance.id)
                        ? GestureDetector(
                            onTap: () {
                              sections.when(
                                  data: (data) {
                                    selectedPretendanceListNotifier
                                        .changeSelection(data.indexOf(section),
                                            pretendance.id);
                                  },
                                  error: (e, s) {},
                                  loading: () {});
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(2, 3))
                                ],
                              ),
                              child: const Icon(Icons.how_to_vote,
                                  color: Colors.white),
                            ),
                          )
                        : const Text(
                            VoteTextConstants.selected,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
