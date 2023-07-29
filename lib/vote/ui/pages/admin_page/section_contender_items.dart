import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/vote/class/contender.dart';
import 'package:myecl/vote/providers/contender_list_provider.dart';
import 'package:myecl/vote/providers/contender_members.dart';
import 'package:myecl/vote/providers/contender_provider.dart';
import 'package:myecl/vote/providers/sections_contender_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/admin_page/contender_card.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SectionContenderItems extends HookConsumerWidget {
  const SectionContenderItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionContender = ref.watch(sectionContenderProvider);
    final membersNotifier = ref.read(contenderMembersProvider.notifier);
    final section = ref.watch(sectionProvider);
    final contenderListNotifier = ref.read(contenderListProvider.notifier);
    final sectionContenderListNotifier =
        ref.read(sectionContenderProvider.notifier);
    final contenderNotifier = ref.read(contenderProvider.notifier);

    final asyncStatus = ref.watch(statusProvider);
    Status status = Status.open;
    asyncStatus.whenData((value) => status = value);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
      value: sectionContender,
      builder: (context, sections) {
        if (sections[section] == null) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text(VoteTextConstants.noPretendanceList)),
          );
        }
        return AsyncChild(
          value: sections[section]!,
          builder: (context, data) => SizedBox(
            height: 190,
            child: HorizontalListView(
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  if (status == Status.waiting)
                    GestureDetector(
                      onTap: () {
                        contenderNotifier.setId(Contender.empty());
                        membersNotifier.setMembers([]);
                        QR.to(VoteRouter.root +
                            VoteRouter.admin +
                            VoteRouter.addEditContender);
                      },
                      child: const CardLayout(
                        width: 120,
                        height: 180,
                        child: Center(
                            child: HeroIcon(
                          HeroIcons.plus,
                          size: 40.0,
                          color: Colors.black,
                        )),
                      ),
                    ),
                  ...data
                      .map((e) => ContenderCard(
                            contender: e,
                            isAdmin: true,
                            onEdit: () {
                              tokenExpireWrapper(ref, () async {
                                contenderNotifier.setId(e);
                                membersNotifier.setMembers(e.members);
                                QR.to(VoteRouter.root +
                                    VoteRouter.admin +
                                    VoteRouter.addEditContender);
                              });
                            },
                            onDelete: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                        title:
                                            VoteTextConstants.deletePretendance,
                                        descriptions: VoteTextConstants
                                            .deletePretendanceDesc,
                                        onYes: () {
                                          tokenExpireWrapper(ref, () async {
                                            final value =
                                                await contenderListNotifier
                                                    .deleteContender(e);
                                            if (value) {
                                              displayVoteToastWithContext(
                                                  TypeMsg.msg,
                                                  VoteTextConstants
                                                      .pretendanceDeleted);
                                              contenderListNotifier
                                                  .copy()
                                                  .then((value) {
                                                sectionContenderListNotifier
                                                    .setTData(section, value);
                                              });
                                            } else {
                                              displayVoteToastWithContext(
                                                  TypeMsg.error,
                                                  VoteTextConstants
                                                      .pretendanceNotDeleted);
                                            }
                                          });
                                        });
                                  });
                            },
                          ))
                      .toList(),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
