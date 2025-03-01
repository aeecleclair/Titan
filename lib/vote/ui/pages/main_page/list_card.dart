import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/card_button.dart';
import 'package:myecl/vote/providers/list_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/selected_list_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/components/list_logo.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ListCard extends HookConsumerWidget {
  final ListReturn list;
  final AnimationController animation;
  final int index;
  final bool enableVote;
  final double votesPercent;
  const ListCard({
    super.key,
    required this.list,
    required this.animation,
    required this.index,
    required this.enableVote,
    required this.votesPercent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNotifier = ref.read(listProvider.notifier);
    final sections = ref.watch(sectionsProvider);
    final selectedList = ref.watch(selectedListProvider);
    final selectedListNotifier = ref.read(selectedListProvider.notifier);
    final status = ref.watch(statusProvider);
    final s = status.maybeWhen(
        data: (value) => value.status, orElse: () => StatusType.closed);
    return Stack(
      children: [
        if (s == StatusType.published)
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(
                  0.08 + 0.05 * index,
                  0.28 + 0.05 * index,
                  curve: Curves.easeOut,
                ),
              ),
            ),
            child: SizedBox(
              height: 175,
              child: Row(
                children: [
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
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
                            bottomLeft: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.shade500.withValues(alpha: 0.5),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.05 + 0.05 * index,
                0.25 + 0.05 * index,
                curve: Curves.easeOut,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(bottom: 15, left: 10),
            height: (s == StatusType.open && enableVote) ? 160 : 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500.withValues(alpha: 0.1),
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
                      list.type != ListType.blank
                          ? ListLogo(list)
                          : const HeroIcon(
                              HeroIcons.cubeTransparent,
                              size: 40,
                            ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            AutoSizeText(
                              list.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              capitalize(
                                list.type.name,
                              ),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 3),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      list.type != ListType.blank
                          ? GestureDetector(
                              onTap: () {
                                listNotifier.setId(list);
                                QR.to(VoteRouter.root + VoteRouter.detail);
                              },
                              child: const HeroIcon(
                                HeroIcons.informationCircle,
                                color: Colors.black,
                                size: 25,
                              ),
                            )
                          : const SizedBox(width: 25),
                    ],
                  ),
                  Center(
                    child: Text(
                      list.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (s == StatusType.open && enableVote)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedList.id != list.id
                            ? GestureDetector(
                                onTap: () {
                                  sections.maybeWhen(
                                    data: (data) {
                                      selectedListNotifier
                                          .changeSelection(list);
                                    },
                                    orElse: () {},
                                  );
                                },
                                child: const CardButton(
                                  color: Colors.black,
                                  child: HeroIcon(
                                    HeroIcons.envelopeOpen,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                VoteTextConstants.selected,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
