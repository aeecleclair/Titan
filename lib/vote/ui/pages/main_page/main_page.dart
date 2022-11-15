import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/class/votes.dart';
import 'package:myecl/vote/providers/is_vote_admin_provider.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/selected_pretendance_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/providers/votes_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/main_page/list_side_item.dart';
import 'package:myecl/vote/ui/pages/main_page/pretendance_card.dart';
import 'package:myecl/vote/ui/pages/main_page/section_title.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final sections = ref.watch(sectionsProvider);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final section = ref.watch(sectionProvider);
    final sectionsPretendances = ref.watch(sectionPretendanceProvider);
    final pretendances = ref.watch(pretendanceListProvider);
    final sectionPretendanceNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    final isAdmin = ref.watch(isVoteAdmin);
    final selectedPretendance = ref.watch(selectedPretendanceProvider);
    final votesNotifier = ref.watch(votesProvider.notifier);
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 2400),
    );
    final pageOpened = useState(false);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    if (!pageOpened.value) {
      animation.forward();
      pageOpened.value = true;
    }
    return Refresher(
      onRefresh: () async {
        final loaners = await sectionsNotifier.loadSectionList();
        loaners.whenData((value) {
          List<Pretendance> list = [];
          pretendances.when(data: (pretendance) {
            list = pretendance;
          }, error: (error, stackTrace) {
            list = [];
          }, loading: () {
            list = [];
          });
          sectionPretendanceNotifier.loadTList(value);
          for (final l in value) {
            sectionPretendanceNotifier.setTData(
                l,
                AsyncValue.data(list
                    .where((element) => element.section.id == l.id)
                    .toList()));
          }
        });
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
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: VoteTextConstants.vote,
                                      descriptions:
                                          VoteTextConstants.confirmVote,
                                      onYes: () {
                                        tokenExpireWrapper(ref, () async {
                                          final result =
                                              await votesNotifier.addVote(Votes(
                                                  ids: selectedPretendance));
                                          if (result) {
                                            displayVoteToastWithContext(
                                                TypeMsg.msg,
                                                VoteTextConstants.voteSuccess);
                                          } else {
                                            displayVoteToastWithContext(
                                                TypeMsg.error,
                                                VoteTextConstants.voteError);
                                          }
                                        });
                                      },
                                    );
                                  });
                            },
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
