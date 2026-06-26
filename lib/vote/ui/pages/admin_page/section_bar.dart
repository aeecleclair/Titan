import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.enums.swagger.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/vote/providers/section_id_provider.dart';
import 'package:titan/vote/providers/sections_list_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/router.dart';
import 'package:titan/vote/ui/pages/admin_page/section_chip.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class SectionBar extends HookConsumerWidget {
  const SectionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sectionIdNotifier = ref.watch(sectionIdProvider.notifier);
    final sectionList = ref.watch(sectionListProvider);
    final sectionListListNotifier = ref.watch(sectionListProvider.notifier);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final asyncStatus = ref.watch(statusProvider);
    VoteStatus status = VoteStatus(status: StatusType.open);
    asyncStatus.whenData((value) => status = value);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return HorizontalListView.builder(
      height: 50,
      items: sectionList.keys.toList(),
      firstChild: (status.status == StatusType.waiting)
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
        isAdmin: status.status == StatusType.waiting,
        onTap: () {
          sectionIdNotifier.setId(key.id);
        },
        onDelete: () async {
          await showDialog(
            context: context,
            builder: (context) => CustomDialogBox(
              title: AppLocalizations.of(context)!.voteDeleteSection,
              descriptions: AppLocalizations.of(
                context,
              )!.voteDeleteSectionDescription,
              onYes: () async {
                final deleteSectionSuccessMsg = AppLocalizations.of(
                  context,
                )!.voteDeletedSection;
                final deleteSectionErrorMsg = AppLocalizations.of(
                  context,
                )!.voteDeletingError;
                final result = await sectionsNotifier.deleteSection(key);
                if (result) {
                  sectionListListNotifier.deleteT(key);
                  displayVoteToastWithContext(
                    TypeMsg.msg,
                    deleteSectionSuccessMsg,
                  );
                } else {
                  displayVoteToastWithContext(
                    TypeMsg.error,
                    deleteSectionErrorMsg,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
