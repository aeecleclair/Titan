import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/web_list_view.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/providers/pretendance_members.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/admin_page/pretendance_card.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SectionPretendenceItems extends HookConsumerWidget {
  const SectionPretendenceItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionPretendance = ref.watch(sectionPretendanceProvider);
    final membersNotifier = ref.watch(pretendanceMembersProvider.notifier);
    final section = ref.watch(sectionProvider);
    final pretendanceListNotifier = ref.watch(pretendanceListProvider.notifier);
    final sectionPretendanceListNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    final pretendanceNotifier = ref.watch(pretendanceProvider.notifier);

    final asyncStatus = ref.watch(statusProvider);
    Status status = Status.open;
    asyncStatus.whenData((value) => status = value);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Column(children: [
      sectionPretendance.when(
        data: (sections) {
          if (sections[section] != null) {
            return sections[section]!.when(
                data: (data) => SizedBox(
                      height: 190,
                      child: HorizontalListView(
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            if (status == Status.waiting)
                              GestureDetector(
                                onTap: () {
                                  pretendanceNotifier
                                      .setId(Pretendance.empty());
                                  membersNotifier.setMembers([]);
                                  QR.to(VoteRouter.root +
                                      VoteRouter.admin +
                                      VoteRouter.addEditPretendance);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    width: 120,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(3, 3),
                                        ),
                                        BoxShadow(
                                          color: Colors.grey.shade200
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(3, 3),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                        child: HeroIcon(
                                      HeroIcons.plus,
                                      size: 40.0,
                                      color: Colors.black,
                                    )),
                                  ),
                                ),
                              ),
                            ...data
                                .map((e) => PretendanceCard(
                                      pretendance: e,
                                      isAdmin: true,
                                      isDetail: false,
                                      onEdit: () {
                                        tokenExpireWrapper(ref, () async {
                                          pretendanceNotifier.setId(e);
                                          membersNotifier.setMembers(e.members);
                                          QR.to(VoteRouter.root +
                                              VoteRouter.admin +
                                              VoteRouter.addEditPretendance);
                                        });
                                      },
                                      onDelete: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CustomDialogBox(
                                                  title: VoteTextConstants
                                                      .deletePretendance,
                                                  descriptions: VoteTextConstants
                                                      .deletePretendanceDesc,
                                                  onYes: () {
                                                    tokenExpireWrapper(ref,
                                                        () async {
                                                      final value =
                                                          await pretendanceListNotifier
                                                              .deletePretendance(
                                                                  e);
                                                      if (value) {
                                                        displayVoteToastWithContext(
                                                            TypeMsg.msg,
                                                            VoteTextConstants
                                                                .pretendanceDeleted);
                                                        pretendanceListNotifier
                                                            .copy()
                                                            .then((value) {
                                                          sectionPretendanceListNotifier
                                                              .setTData(section,
                                                                  value);
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
                error: (Object error, StackTrace? stackTrace) {
                  return Center(child: Text('Error $error'));
                },
                loading: () {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                });
          } else {
            return const SizedBox(
              height: 200,
              child: Center(child: Text(VoteTextConstants.noPretendanceList)),
            );
          }
        },
        error: (Object error, StackTrace? stackTrace) {
          return Center(child: Text('Error $error'));
        },
        loading: () {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        },
      )
    ]);
  }
}
