import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/card_button.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/selected_contender_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/repositories/status_repository.dart';
import 'package:titan/vote/router.dart';
import 'package:titan/vote/tools/constants.dart';
import 'package:titan/vote/ui/components/contender_logo.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ContenderCard extends HookConsumerWidget {
  final Contender contender;
  final AnimationController animation;
  final int index;
  final bool enableVote;
  final double votesPercent;
  const ContenderCard({
    super.key,
    required this.contender,
    required this.animation,
    required this.index,
    required this.enableVote,
    required this.votesPercent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contenderNotifier = ref.read(contenderProvider.notifier);
    final sections = ref.watch(sectionsProvider);
    final selectedContender = ref.watch(selectedContenderProvider);
    final selectedContenderNotifier = ref.read(
      selectedContenderProvider.notifier,
    );
    final status = ref.watch(statusProvider);
    final s = status.maybeWhen(
      data: (value) => value,
      orElse: () => Status.closed,
    );
    return Stack(
      children: [
        if (s == Status.published)
          SlideTransition(
            position:
                Tween<Offset>(
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
                        width:
                            (MediaQuery.of(context).size.width - 92) *
                            votesPercent,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500.withValues(
                                alpha: 0.5,
                              ),
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
          position:
              Tween<Offset>(
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
            height: (s == Status.open && enableVote) ? 160 : 120,
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
                      contender.listType != ListType.blank
                          ? ContenderLogo(contender)
                          : const HeroIcon(HeroIcons.cubeTransparent, size: 40),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            AutoSizeText(
                              contender.name,
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
                                contender.listType.toString().split('.').last,
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
                      contender.listType != ListType.blank
                          ? GestureDetector(
                              onTap: () {
                                contenderNotifier.setId(contender);
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
                      contender.description,
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
                  if (s == Status.open && enableVote)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        selectedContender.id != contender.id
                            ? GestureDetector(
                                onTap: () {
                                  sections.maybeWhen(
                                    data: (data) {
                                      selectedContenderNotifier.changeSelection(
                                        contender,
                                      );
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
