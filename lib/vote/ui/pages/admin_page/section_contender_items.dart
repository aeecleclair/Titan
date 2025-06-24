import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/contender_list_provider.dart';
import 'package:titan/vote/providers/contender_members.dart';
import 'package:titan/vote/providers/contender_provider.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/repositories/status_repository.dart';
import 'package:titan/vote/router.dart';
import 'package:titan/vote/tools/constants.dart';
import 'package:titan/vote/ui/pages/admin_page/contender_card.dart';
import 'package:qlevar_router/qlevar_router.dart';

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

    final asyncStatus = ref.watch(statusProvider);
    Status status = Status.open;
    asyncStatus.whenData((value) => status = value);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AsyncChild(
      value: sectionContender[section]!,
      builder: (context, data) => HorizontalListView.builder(
        height: 190,
        firstChild: (status == Status.waiting)
            ? GestureDetector(
                onTap: () {
                  contenderNotifier.setId(Contender.empty());
                  membersNotifier.setMembers([]);
                  QR.to(
                    VoteRouter.root +
                        VoteRouter.admin +
                        VoteRouter.addEditContender,
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
        itemBuilder: (context, e, i) => ContenderCard(
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
                  title: VoteTextConstants.deletePretendance,
                  descriptions: VoteTextConstants.deletePretendanceDesc,
                  onYes: () {
                    tokenExpireWrapper(ref, () async {
                      final value = await contenderListNotifier.deleteContender(
                        e,
                      );
                      if (value) {
                        displayVoteToastWithContext(
                          TypeMsg.msg,
                          VoteTextConstants.pretendanceDeleted,
                        );
                        contenderListNotifier.copy().then((value) {
                          sectionContenderListNotifier.setTData(section, value);
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
