import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/vote/providers/list_list_provider.dart';
import 'package:titan/vote/providers/list_members.dart';
import 'package:titan/vote/providers/list_provider.dart';
import 'package:titan/vote/providers/sections_list_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/router.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/vote/ui/pages/admin_page/list_card.dart';

class SectionListItems extends HookConsumerWidget {
  const SectionListItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionList = ref.watch(sectionListProvider);
    final membersNotifier = ref.read(listMembersProvider.notifier);
    final section = ref.watch(sectionProvider);
    final listListNotifier = ref.read(listListProvider.notifier);
    final sectionListListNotifier = ref.read(sectionListProvider.notifier);
    final listNotifier = ref.read(listProvider.notifier);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
      value: sectionList[section]!,
      builder: (context, data) => Column(
        children: data
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20.0,
                ),
                child: ListCard(
                  list: e,
                  isAdmin: true,
                  onEdit: () {
                    listNotifier.setId(e);
                    membersNotifier.setMembers(e.members);
                    QR.to(
                      VoteRouter.root +
                          VoteRouter.admin +
                          VoteRouter.addEditList,
                    );
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
                          onYes: () async {
                            final pretendanceDeletedMsg = AppLocalizations.of(
                              context,
                            )!.votePretendanceDeleted;
                            final pretendanceNotDeletedMsg =
                                AppLocalizations.of(
                                  context,
                                )!.votePretendanceNotDeleted;
                            final value = await listListNotifier.deleteList(e);
                            if (value) {
                              displayVoteToastWithContext(
                                TypeMsg.msg,
                                pretendanceDeletedMsg,
                              );
                              listListNotifier.copy().then((value) {
                                sectionListListNotifier.setTData(
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
