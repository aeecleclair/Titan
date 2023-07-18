import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:myecl/tools/ui/item_chip.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';
import 'package:myecl/vote/providers/sections_contender_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/admin_page/section_chip.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SectionBar extends HookConsumerWidget {
  const SectionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sectionIdNotifier = ref.watch(sectionIdProvider.notifier);
    final sectionContender = ref.watch(sectionContenderProvider);
    final sectionContenderListNotifier =
        ref.watch(sectionContenderProvider.notifier);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final asyncStatus = ref.watch(statusProvider);
    Status status = Status.open;
    asyncStatus.whenData((value) => status = value);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return HorizontalListView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          if (status == Status.waiting)
            ItemChip(
              onTap: () {
                QR.to(
                    VoteRouter.root + VoteRouter.admin + VoteRouter.addSection);
              },
              selected: false,
              child: const HeroIcon(
                HeroIcons.plus,
                color: Colors.black,
              ),
            ),
          if (section.id != Section.empty().id)
            ...sectionContender.when(data: (sections) {
              return sections
                  .map((key, value) => MapEntry(
                      SectionChip(
                          label: key.name,
                          selected: section.id == key.id,
                          isAdmin: status == Status.waiting,
                          onTap: () async {
                            tokenExpireWrapper(ref, () async {
                              sectionIdNotifier.setId(key.id);
                            });
                          },
                          onDelete: () async {
                            tokenExpireWrapper(ref, () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) => CustomDialogBox(
                                        title: VoteTextConstants.deleteSection,
                                        descriptions: VoteTextConstants
                                            .deleteSectionDescription,
                                        onYes: () async {
                                          final result = await sectionsNotifier
                                              .deleteSection(key);
                                          if (result) {
                                            sectionContenderListNotifier
                                                .deleteT(key);
                                            displayVoteToastWithContext(
                                                TypeMsg.msg,
                                                VoteTextConstants
                                                    .deletedSection);
                                          } else {
                                            displayVoteToastWithContext(
                                                TypeMsg.error,
                                                VoteTextConstants
                                                    .deletingError);
                                          }
                                        },
                                      ));
                            });
                          }),
                      value))
                  .keys;
            }, loading: () {
              return const [
                SizedBox(
                  width: 20,
                )
              ];
            }, error: (error, stack) {
              return const [
                SizedBox(
                  width: 20,
                )
              ];
            }),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
