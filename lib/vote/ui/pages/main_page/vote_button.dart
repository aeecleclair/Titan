import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/votes.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/selected_pretendance_provider.dart';
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
    final selectedPretendance = ref.watch(selectedPretendanceProvider);
    final selectedPretendanceNotifier =
        ref.watch(selectedPretendanceProvider.notifier);
    final votedSectionNotifier = ref.watch(votedSectionProvider.notifier);
    final votedSection = ref.watch(votedSectionProvider);
    List<String> alreadyVotedSection = [];
    votedSection.when(
        data: (voted) {
          alreadyVotedSection = voted;
        },
        error: (error, stackTrace) {},
        loading: () {});

    final status = ref.watch(statusProvider);
    final s = status.when(
        data: (value) => value,
        loading: () => Status.closed,
        error: (error, stack) => Status.closed);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: GestureDetector(
        onTap: () {
          if (selectedPretendance.id != "" &&
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
                            .addVote(Votes(id: selectedPretendance.id));
                        if (result) {
                          votedSectionNotifier.addVote(section.id);
                          selectedPretendanceNotifier.clear();
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
                colors: (selectedPretendance.id == "" && s != Status.open) ||
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
              selectedPretendance.id != ""
                  ? VoteTextConstants.voteFor + selectedPretendance.name
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
                  color: (selectedPretendance.id == "" && s != Status.open) ||
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
