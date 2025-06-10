import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/vote/providers/section_id_provider.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/repositories/status_repository.dart';
import 'package:titan/vote/router.dart';
import 'package:titan/vote/tools/constants.dart';
import 'package:titan/vote/ui/pages/admin_page/section_chip.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SectionBar extends HookConsumerWidget {
  const SectionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sectionIdNotifier = ref.watch(sectionIdProvider.notifier);
    final sectionContender = ref.watch(sectionContenderProvider);
    final sectionContenderListNotifier = ref.watch(
      sectionContenderProvider.notifier,
    );
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final asyncStatus = ref.watch(statusProvider);
    Status status = Status.open;
    asyncStatus.whenData((value) => status = value);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return HorizontalListView.builder(
      height: 40,
      items: sectionContender.keys.toList(),
      firstChild: (status == Status.waiting)
          ? ItemChip(
              onTap: () {
                QR.to(
                  VoteRouter.root + VoteRouter.admin + VoteRouter.addSection,
                );
              },
              child: const HeroIcon(HeroIcons.plus, color: Colors.black),
            )
          : null,
      itemBuilder: (context, key, i) => SectionChip(
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
                descriptions: VoteTextConstants.deleteSectionDescription,
                onYes: () async {
                  final result = await sectionsNotifier.deleteSection(key);
                  if (result) {
                    sectionContenderListNotifier.deleteT(key);
                    displayVoteToastWithContext(
                      TypeMsg.msg,
                      VoteTextConstants.deletedSection,
                    );
                  } else {
                    displayVoteToastWithContext(
                      TypeMsg.error,
                      VoteTextConstants.deletingError,
                    );
                  }
                },
              ),
            );
          });
        },
      ),
    );
  }
}
