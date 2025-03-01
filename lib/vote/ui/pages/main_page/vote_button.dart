import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/providers/selected_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/voted_section_provider.dart';
import 'package:myecl/vote/providers/votes_provider.dart';
import 'package:myecl/vote/tools/constants.dart';

class VoteButton extends HookConsumerWidget {
  const VoteButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final votesNotifier = ref.watch(votesProvider.notifier);
    final selectedList = ref.watch(selectedListProvider);
    final selectedListNotifier =
        ref.watch(selectedListProvider.notifier);
    final votedSectionNotifier = ref.watch(votedSectionProvider.notifier);
    final votedSection = ref.watch(votedSectionProvider);
    List<String> alreadyVotedSection = [];
    votedSection.maybeWhen(
      data: (voted) {
        alreadyVotedSection = voted;
      },
      orElse: () {},
    );

    final status = ref.watch(statusProvider);
    final s =
        status.maybeWhen(data: (value) => value.status, orElse: () => StatusType.closed);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: GestureDetector(
        onTap: () {
          if (selectedList.id != "" &&
              s == StatusType.open &&
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
                          .addVote(VoteBase(listId: selectedList.id));
                      if (result) {
                        votedSectionNotifier.addVote(section.id);
                        selectedListNotifier.clear();
                        displayVoteToastWithContext(
                          TypeMsg.msg,
                          VoteTextConstants.voteSuccess,
                        );
                      } else {
                        displayVoteToastWithContext(
                          TypeMsg.error,
                          VoteTextConstants.voteError,
                        );
                      }
                    });
                  },
                );
              },
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: (selectedList.id == "" && s != StatusType.open) ||
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
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              selectedList.id != ""
                  ? VoteTextConstants.voteFor + selectedList.name
                  : alreadyVotedSection.contains(section.id)
                      ? VoteTextConstants.alreadyVoted
                      : s == StatusType.open
                          ? VoteTextConstants.chooseList
                          : s == StatusType.waiting
                              ? VoteTextConstants.notOpenedVote
                              : s == StatusType.closed
                                  ? VoteTextConstants.closedVote
                                  : VoteTextConstants.onGoingCount,
              style: TextStyle(
                color: (selectedList.id == "" && s != StatusType.open) ||
                        alreadyVotedSection.contains(section.id)
                    ? Colors.black
                    : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
