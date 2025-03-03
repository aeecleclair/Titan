import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/vote/providers/list_list_provider.dart';
import 'package:myecl/vote/providers/list_members.dart';
import 'package:myecl/vote/providers/list_provider.dart';
import 'package:myecl/vote/providers/sections_list_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/admin_page/list_card.dart';
import 'package:qlevar_router/qlevar_router.dart';

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

    final asyncStatus = ref.watch(statusProvider);
    VoteStatus status = VoteStatus(status: StatusType.open);
    asyncStatus.whenData((value) => status = value);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
      value: sectionList[section]!,
      builder: (context, data) => HorizontalListView.builder(
        height: 190,
        firstChild: (status.status == StatusType.waiting)
            ? GestureDetector(
                onTap: () {
                  listNotifier.setId(EmptyModels.empty<ListReturn>());
                  membersNotifier.setMembers([]);
                  QR.to(
                    VoteRouter.root + VoteRouter.admin + VoteRouter.addEditList,
                  );
                },
                child: const CardLayout(
                  width: 120,
                  height: 180,
                  child: Center(
                    child: HeroIcon(
                      HeroIcons.plus,
                      size: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : null,
        items: data,
        itemBuilder: (context, e, i) => ListCard(
          list: e,
          isAdmin: true,
          onEdit: () {
            tokenExpireWrapper(ref, () async {
              listNotifier.setId(e);
              membersNotifier.setMembers(e.members);
              QR.to(
                VoteRouter.root + VoteRouter.admin + VoteRouter.addEditList,
              );
            });
          },
          onDelete: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return CustomDialogBox(
                  title: VoteTextConstants.deletePretendance,
                  descriptions: VoteTextConstants.deletePretendanceDesc,
                  onYes: () {
                    tokenExpireWrapper(ref, () async {
                      final value = await listListNotifier.deleteList(e.id);
                      if (value) {
                        displayVoteToastWithContext(
                          TypeMsg.msg,
                          VoteTextConstants.pretendanceDeleted,
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
                          VoteTextConstants.pretendanceNotDeleted,
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
    );
  }
}
