import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/vote/providers/contender_list_provider.dart';
import 'package:titan/vote/providers/contender_members.dart';
import 'package:titan/vote/providers/contender_provider.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/router.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/vote/ui/pages/admin_page/contender_card.dart';

class SectionContenderItems extends HookConsumerWidget {
  const SectionContenderItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionContender = ref.watch(sectionContenderProvider);
    final membersNotifier = ref.read(contenderMembersProvider.notifier);
    final section = ref.watch(sectionProvider);
    final contenderListNotifier = ref.read(contenderListProvider.notifier);
    final sectionContenderListNotifier = ref.read(
      sectionContenderProvider.notifier,
    );
    final contenderNotifier = ref.read(contenderProvider.notifier);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
      value: sectionContender[section]!,
      builder: (context, data) => Column(
        children: data
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20.0,
                ),
                child: ContenderCard(
                  contender: e,
                  isAdmin: true,
                  onEdit: () {
                    tokenExpireWrapper(ref, () async {
                      contenderNotifier.setId(e);
                      membersNotifier.setMembers(e.members);
                      QR.to(
                        VoteRouter.root +
                            VoteRouter.admin +
                            VoteRouter.addEditContender,
                      );
                    });
                  },
                  onDelete: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialogBox(
                          title: AppLocalizations.of(
                            context,
                          )!.voteDeletePretendance,
                          descriptions: AppLocalizations.of(
                            context,
                          )!.voteDeletePretendanceDesc,
                          onYes: () {
                            final pretendanceDeletedMsg = AppLocalizations.of(
                              context,
                            )!.votePretendanceDeleted;
                            final pretendanceNotDeletedMsg =
                                AppLocalizations.of(
                                  context,
                                )!.votePretendanceNotDeleted;
                            tokenExpireWrapper(ref, () async {
                              final value = await contenderListNotifier
                                  .deleteContender(e);
                              if (value) {
                                displayVoteToastWithContext(
                                  TypeMsg.msg,
                                  pretendanceDeletedMsg,
                                );
                                contenderListNotifier.copy().then((value) {
                                  sectionContenderListNotifier.setTData(
                                    section,
                                    value,
                                  );
                                });
                              } else {
                                displayVoteToastWithContext(
                                  TypeMsg.error,
                                  pretendanceNotDeletedMsg,
                                );
                              }
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
