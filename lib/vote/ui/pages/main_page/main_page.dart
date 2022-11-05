import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/main_page/list_side_item.dart';
import 'package:myecl/vote/ui/pages/main_page/pretendance_card.dart';
import 'package:myecl/vote/ui/pages/main_page/section_title.dart';
import 'package:myecl/vote/ui/refresh_indicator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final sections = ref.watch(sectionsProvider);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final section = ref.watch(sectionProvider);
    final pretendanceNotifier = ref.watch(pretendanceProvider.notifier);
    final sectionsPretendances = ref.watch(sectionPretendanceProvider);
    final sectionPretendanceNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    final isAdmin = true;
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 2400),
    );
    final pageOpened = useState(false);
    if (!pageOpened.value) {
      animation.forward();
      print(section);
      pageOpened.value = true;
    }
    return VoteRefresher(
      onRefresh: () async {
        await sectionsNotifier.loadSectionList();
        sections.whenData((value) {
          if (value.isNotEmpty) {
            sectionPretendanceNotifier.loadTList(value);
          }
        });
        await pretendanceNotifier.loadPretendanceListBySection(section.id);
        sectionPretendanceNotifier.setTData(
            section, await pretendanceNotifier.copy());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
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
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: pretendanceList.isNotEmpty
                                            ? Column(
                                                children:
                                                    pretendanceList[section]!
                                                        .when(
                                                data: (pretendance) =>
                                                    pretendance.map((e) {
                                                  final index =
                                                      pretendance.indexOf(e);
                                                  return PretendanceCard(
                                                      index: index,
                                                      pretendance: e,
                                                      animation: animation);
                                                }).toList(),
                                                loading: () => const [
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                ],
                                                error: (error, stack) => const [
                                                  Center(
                                                    child:
                                                        Text("Error occured"),
                                                  )
                                                ],
                                              ))
                                            : const SizedBox(
                                                height: 150,
                                                child: Center(
                                                  child: Text(VoteTextConstants
                                                      .noPretendanceList),
                                                ),
                                              ),
                                      ),
                                    ),
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
                      if (sectionList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 12),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(
                                child: Text(
                                  VoteTextConstants.vote,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
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
      ),
    );
  }
}
