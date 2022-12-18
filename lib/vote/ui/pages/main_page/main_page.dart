import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/is_ae_member_provider.dart';
import 'package:myecl/vote/providers/is_vote_admin_provider.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/providers/pretendance_logo_provider.dart';
import 'package:myecl/vote/providers/pretendance_logos_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/providers/voted_section_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/ui/pages/main_page/list_pretendence_card.dart';
import 'package:myecl/vote/ui/pages/main_page/list_side_item.dart';
import 'package:myecl/vote/ui/pages/main_page/section_title.dart';
import 'package:myecl/vote/ui/pages/main_page/vote_button.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final statusNotifier = ref.watch(statusProvider.notifier);
    final isAdmin = ref.watch(isVoteAdmin);
    final sections = ref.watch(sectionsProvider);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final sectionsPretendances = ref.watch(sectionPretendanceProvider);
    final pretendances = ref.watch(pretendanceListProvider);
    final pretendancesNotifier = ref.watch(pretendanceListProvider.notifier);
    final sectionPretendanceNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 2400),
    );
    final status = ref.watch(statusProvider);
    final s = status.when(
      data: (value) => value,
      loading: () => Status.closed,
      error: (e, s) => Status.closed,
    );
    if (s == Status.open) {
      ref.watch(votedSectionProvider.notifier).getVotedSections();
    }
    final logosNotifier = ref.watch(pretendenceLogoProvider.notifier);
    final pretendanceLogosNotifier =
        ref.watch(pretendanceLogosProvider.notifier);

    final isAEMember = ref.watch(isAEMemberProvider);

    if (isAEMember) {
      return Refresher(
        onRefresh: () async {
          await statusNotifier.loadStatus();
          if (s == Status.open) {
            await ref.watch(votedSectionProvider.notifier).getVotedSections();
          }
          await pretendancesNotifier.loadPretendanceList();
          final sections = await sectionsNotifier.loadSectionList();
          sections.whenData((value) {
            List<Pretendance> list = [];
            pretendances.whenData((pretendance) {
              list = pretendance;
            });
            sectionPretendanceNotifier.loadTList(value);
            pretendanceLogosNotifier.loadTList(list);
            for (final l in value) {
              sectionPretendanceNotifier.setTData(
                  l,
                  AsyncValue.data(list
                      .where((element) => element.section.id == l.id)
                      .toList()));
            }
            for (final l in list) {
              logosNotifier.getLogo(l.id).then((value) =>
                  pretendanceLogosNotifier.setTData(
                      l, AsyncValue.data([value])));
            }
          });
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(children: [
                SizedBox(
                  height: isAdmin ? 10 : 15,
                ),
                sections.when(
                  data: (sectionList) => Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            (isAdmin ? 215 : 220),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListSideItem(
                                sectionList: sectionList, animation: animation),
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                child: sectionsPretendances.when(
                                  data: (pretendanceList) => Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SectionTitle(sectionList: sectionList),
                                        if (isAdmin)
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                pageNotifier.setVotePage(
                                                    VotePage.admin);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          blurRadius: 10,
                                                          offset: const Offset(
                                                              0, 5))
                                                    ]),
                                                child: Row(
                                                  children: const [
                                                    HeroIcon(
                                                        HeroIcons.userGroup,
                                                        color: Colors.white),
                                                    SizedBox(width: 10),
                                                    Text("Admin",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Expanded(
                                        child: ListPretendenceCard(
                                      animation: animation,
                                    ))
                                  ]),
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  error: (error, stack) => const Center(
                                    child: Text('Error'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (sectionList.isNotEmpty) const VoteButton(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => const Center(child: Text('Error')),
                ),
              ])),
        ),
      );
    } else {
      return SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(
                child: Text(
                  "Vous n'êtes pas membre de l'AE",
                  style: TextStyle(fontSize: 20),
                ),
              )));
    }
  }
}
