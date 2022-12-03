import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/ui/section_chip.dart';

class SectionBar extends HookConsumerWidget {
  const SectionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider);
    final sectionIdNotifier = ref.watch(sectionIdProvider.notifier);
    final sectionPretendance = ref.watch(sectionPretendanceProvider);
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final sectionPretendanceListNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final asyncStatus = ref.watch(statusProvider);
    Status status = Status.open;
    asyncStatus.whenData((value) => status = value);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          if (status == Status.waiting)
            GestureDetector(
              onTap: () {
                pageNotifier.setVotePage(VotePage.addSection);
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Chip(
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: HeroIcon(
                        HeroIcons.plus,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.grey.shade200,
                  )),
            ),
          if (section.id != Section.empty().id)
            ...sectionPretendance.when(data: (sections) {
              return sections
                  .map((key, value) => MapEntry(
                      SectionChip(
                          label: capitalize(key.name),
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
                                        title: 'Supprimer la section',
                                        descriptions:
                                            'Voulez-vous vraiment supprimer cette section ?',
                                        onYes: () async {
                                          final result = await sectionsNotifier
                                              .deleteSection(key);
                                          if (result) {
                                            sectionPretendanceListNotifier
                                                .deleteT(key);
                                            displayVoteToastWithContext(
                                                TypeMsg.msg,
                                                'Section supprimée avec succès');
                                          } else {
                                            displayVoteToastWithContext(
                                                TypeMsg.error,
                                                'Une erreur est survenue');
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
