import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_logo_provider.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/pretendance_logos_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/selected_pretendance_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/tools/constants.dart';

class PretendanceCard extends HookConsumerWidget {
  final Pretendance pretendance;
  final AnimationController animation;
  final int index;
  final bool enableVote;
  final double votesPercent;
  const PretendanceCard(
      {super.key,
      required this.pretendance,
      required this.animation,
      required this.index,
      required this.enableVote,
      required this.votesPercent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final pretendanceNotifier = ref.watch(pretendanceProvider.notifier);
    final sections = ref.watch(sectionsProvider);
    final selectedPretendance = ref.watch(selectedPretendanceProvider);
    final selectedPretendanceNotifier =
        ref.watch(selectedPretendanceProvider.notifier);
    final pretendanceLogos = ref.watch(pretendanceLogosProvider);
    final pretendanceLogosNotifier =
        ref.watch(pretendanceLogosProvider.notifier);
    final logoNotifier = ref.watch(pretendenceLogoProvider.notifier);
    final status = ref.watch(statusProvider);
    final s = status.when(
        data: (value) => value,
        loading: () => Status.closed,
        error: (error, stack) => Status.closed);
    return Stack(
      children: [
        if (s == Status.published)
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).animate(CurvedAnimation(
                parent: animation,
                curve: Interval(0.08 + 0.05 * index, 0.28 + 0.05 * index,
                    curve: Curves.easeOut))),
            child: SizedBox(
              height: 175,
              child: Row(children: [
                Expanded(
                  child: (votesPercent) < 0.3
                      ? Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '${(votesPercent * 100).toStringAsFixed(1)}%',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                      : Container(),
                ),
                Column(
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(bottom: 15),
                      height: 70,
                      width: (MediaQuery.of(context).size.width - 92) *
                          votesPercent,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: (votesPercent >= 0.3)
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '${(votesPercent * 100).toStringAsFixed(1)}%',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        SlideTransition(
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
              height: (s == Status.open && enableVote) ? 160 : 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500.withOpacity(0.1),
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
                        pretendance.listType != ListType.blank
                            ? pretendanceLogos.when(
                                data: (data) {
                                  if (data[pretendance] != null) {
                                    return data[pretendance]!.when(
                                        data: (data) {
                                      if (data.isNotEmpty) {
                                        return Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: data.first.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      } else {
                                        logoNotifier
                                            .getLogo(pretendance.id)
                                            .then((value) {
                                          pretendanceLogosNotifier.setTData(
                                              pretendance, AsyncData([value]));
                                        });
                                        return const HeroIcon(
                                          HeroIcons.userCircle,
                                          size: 40,
                                        );
                                      }
                                    }, loading: () {
                                      return const SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }, error: (error, stack) {
                                      return const SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                          child: Icon(Icons.error),
                                        ),
                                      );
                                    });
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (error, stack) => Text('Error $error'))
                            : const HeroIcon(
                                HeroIcons.cubeTransparent,
                                size: 40,
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              AutoSizeText(pretendance.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        pretendance.listType != ListType.blank
                            ? GestureDetector(
                                onTap: () {
                                  pretendanceNotifier.setId(pretendance);
                                  pageNotifier
                                      .setVotePage(VotePage.detailPageFromMain);
                                },
                                child: const HeroIcon(
                                  HeroIcons.informationCircle,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              )
                            : const SizedBox(
                                width: 25,
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
                    if (s == Status.open && enableVote)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selectedPretendance.id != pretendance.id
                              ? GestureDetector(
                                  onTap: () {
                                    sections.when(
                                        data: (data) {
                                          selectedPretendanceNotifier
                                              .changeSelection(pretendance);
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
                                            color:
                                                Colors.black.withOpacity(0.2),
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
        ),
      ],
    );
  }
}
