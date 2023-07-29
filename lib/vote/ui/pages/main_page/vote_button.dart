import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/votes.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/selected_contender_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/voted_section_provider.dart';
import 'package:myecl/vote/providers/votes_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/tools/constants.dart';

class VoteButton extends HookConsumerWidget {
  const VoteButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final votesNotifier = ref.watch(votesProvider.notifier);
    final selectedContender = ref.watch(selectedContenderProvider);
    final selectedContenderNotifier =
        ref.watch(selectedContenderProvider.notifier);
    final votedSectionNotifier = ref.watch(votedSectionProvider.notifier);
    final votedSection = ref.watch(votedSectionProvider);
    List<String> alreadyVotedSection = [];
    votedSection.maybeWhen(
        data: (voted) {
          alreadyVotedSection = voted;
        },
        orElse: () {});

    final status = ref.watch(statusProvider);
    final s = status.maybeWhen(
        data: (value) => value,
        orElse: () => Status.closed);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: GestureDetector(
        onTap: () {
          if (selectedContender.id != "" &&
              s == Status.open &&
              !alreadyVotedSection.contains(section.id)) {
            showDialog(
                context: context,
                builder: (context) {
                  return CustomDialogBox(
                    title: VoteTextConstants.vote,
                    descriptions: VoteTextConstants.confirmVote,
                    onYes: () {
                      tokenExpireWrapper(ref, () async {
                        final result = await votesNotifier
                            .addVote(Votes(id: selectedContender.id));
                        if (result) {
                          votedSectionNotifier.addVote(section.id);
                          selectedContenderNotifier.clear();
                          displayVoteToastWithContext(
                              TypeMsg.msg, VoteTextConstants.voteSuccess);
                        } else {
                          displayVoteToastWithContext(
                              TypeMsg.error, VoteTextConstants.voteError);
                        }
                      });
                    },
                  );
                });
          }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 12),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: (selectedContender.id == "" && s != Status.open) ||
                        alreadyVotedSection.contains(section.id)
                    ? [
                        Colors.white,
                        Colors.grey.shade50,
                      ]
                    : [Colors.grey.shade900, Colors.black],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(3, 3),
                )
              ]),
          child: Center(
            child: Text(
              selectedContender.id != ""
                  ? VoteTextConstants.voteFor + selectedContender.name
                  : alreadyVotedSection.contains(section.id)
                      ? VoteTextConstants.alreadyVoted
                      : s == Status.open
                          ? VoteTextConstants.chooseList
                          : s == Status.waiting
                              ? VoteTextConstants.notOpenedVote
                              : s == Status.closed
                                  ? VoteTextConstants.closedVote
                                  : VoteTextConstants.onGoingCount,
              style: TextStyle(
                  color: (selectedContender.id == "" && s != Status.open) ||
                          alreadyVotedSection.contains(section.id)
                      ? Colors.black
                      : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
