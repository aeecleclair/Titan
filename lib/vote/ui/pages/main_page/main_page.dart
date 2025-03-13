import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/vote/providers/can_vote_provider.dart';
import 'package:myecl/vote/providers/is_vote_admin_provider.dart';
import 'package:myecl/vote/providers/list_list_provider.dart';
import 'package:myecl/vote/providers/list_logo_provider.dart';
import 'package:myecl/vote/providers/list_logos_provider.dart';
import 'package:myecl/vote/providers/sections_list_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/voted_section_provider.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/main_page/list_list_card.dart';
import 'package:myecl/vote/ui/pages/main_page/list_side_item.dart';
import 'package:myecl/vote/ui/pages/main_page/section_title.dart';
import 'package:myecl/vote/ui/pages/main_page/vote_button.dart';
import 'package:myecl/vote/ui/vote.dart';
import 'package:qlevar_router/qlevar_router.dart';

class VoteMainPage extends HookConsumerWidget {
  const VoteMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusNotifier = ref.watch(statusProvider.notifier);
    final isAdmin = ref.watch(isVoteAdminProvider);
    final sections = ref.watch(sectionsProvider);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final lists = ref.watch(listListProvider);
    final listsNotifier = ref.watch(listListProvider.notifier);
    final sectionListNotifier = ref.watch(sectionListProvider.notifier);
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 2400),
    );
    final status = ref.watch(statusProvider);
    final s = status.maybeWhen(
      data: (value) => value.status,
      orElse: () => StatusType.closed,
    );
    if (s == StatusType.open) {
      ref.watch(votedSectionProvider.notifier).getVotedSections();
    }
    final logosNotifier = ref.watch(listLogoProvider.notifier);
    final listLogosNotifier = ref.watch(listLogosProvider.notifier);

    final canVote = ref.watch(canVoteProvider);

    if (!canVote) {
      return VoteTemplate(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                if (isAdmin)
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: AdminButton(
                          onTap: () {
                            QR.to(VoteRouter.root + VoteRouter.admin);
                          },
                        ),
                      ),
                    ],
                  ),
                const Expanded(
                  child: Center(
                    child: Text(
                      VoteTextConstants.canNotVote,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return VoteTemplate(
      child: Refresher(
        onRefresh: () async {
          await statusNotifier.loadStatus();
          if (s == StatusType.open) {
            await ref.watch(votedSectionProvider.notifier).getVotedSections();
          }
          await listsNotifier.loadListList();
          final sections = await sectionsNotifier.loadSectionList();
          sections.whenData((value) {
            List<ListReturn> listReturn = [];
            lists.whenData((list) {
              listReturn = list;
            });
            sectionListNotifier.loadTList(value);
            listLogosNotifier
                .loadTList(listReturn.map((list) => list.id).toList());
            for (final l in value) {
              sectionListNotifier.setTData(
                l,
                AsyncValue.data(
                  listReturn
                      .where((element) => element.section.id == l.id)
                      .toList(),
                ),
              );
            }
            for (final list in listReturn) {
              logosNotifier.getLogo(list.id).then(
                    (value) => listLogosNotifier.setTData(
                      list.id,
                      AsyncValue.data([value]),
                    ),
                  );
            }
          });
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              children: [
                SizedBox(
                  height: isAdmin ? 10 : 15,
                ),
                AsyncChild(
                  value: sections,
                  builder: (context, sectionList) => Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            (s == StatusType.open
                                ? isAdmin
                                    ? 215
                                    : 220
                                : isAdmin
                                    ? 150
                                    : 155),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListSideItem(
                              sectionList: sectionList,
                              animation: animation,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SectionTitle(
                                          sectionList: sectionList,
                                        ),
                                        if (isAdmin)
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: 20,
                                            ),
                                            child: AdminButton(
                                              onTap: () {
                                                QR.to(
                                                  VoteRouter.root +
                                                      VoteRouter.admin,
                                                );
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Expanded(
                                      child: ListListCard(
                                        animation: animation,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (sectionList.isNotEmpty && s == StatusType.open)
                        const VoteButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
