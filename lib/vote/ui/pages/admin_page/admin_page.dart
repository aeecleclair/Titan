import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/providers/result_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/show_graph_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/admin_page/open_excel.dart';
import 'package:myecl/vote/ui/pages/admin_page/section_bar.dart';
import 'package:myecl/vote/ui/pages/admin_page/section_pretendence_items.dart';
import 'package:myecl/vote/ui/pages/admin_page/vote_bars.dart';
import 'package:myecl/vote/ui/pages/admin_page/vote_count.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionPretendanceListNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final pretendances = ref.watch(pretendanceListProvider);
    final asyncStatus = ref.watch(statusProvider);
    final statusNotifier = ref.watch(statusProvider.notifier);
    final showVotes = ref.watch(showGraphProvider);
    final showVotesNotifier = ref.watch(showGraphProvider.notifier);
    final resultsNotifier = ref.watch(resultProvider.notifier);
    Status status = Status.open;
    asyncStatus.whenData((value) => status = value);
    ref.watch(userList);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Refresher(
      onRefresh: () async {
        await statusNotifier.loadStatus();
        await resultsNotifier.loadResult();
        final sections = await sectionsNotifier.loadSectionList();
        sections.whenData((value) async {
          List<Pretendance> list = [];
          pretendances.when(data: (pretendance) {
            list = pretendance;
          }, error: (error, stackTrace) {
            list = [];
          }, loading: () {
            list = [];
          });
          sectionPretendanceListNotifier.loadTList(value);
          for (final l in value) {
            sectionPretendanceListNotifier.setTData(
                l,
                AsyncValue.data(list
                    .where((element) => element.section.id == l.id)
                    .toList()));
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const SectionBar(),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(VoteTextConstants.pretendance,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 205, 205, 205))),
              ),
            ),
            const SizedBox(height: 10),
            const SectionPretendenceItems(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(VoteTextConstants.vote,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 205, 205, 205))),
                    if (showVotes && (status == Status.counting))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showVotesNotifier.toggle(false);
                            },
                            child: const HeroIcon(
                              HeroIcons.eyeSlash,
                              size: 25.0,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              statusNotifier.publishVote();
                            },
                            child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black,
                          ),
                          child: const Text(VoteTextConstants.publish,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                          ),
                        ],
                      ),
                    // if (showVotes && (status == Status.counting || status == Status.published))
                    //   GestureDetector(
                    //     onTap: () {
                    //       openExcel(ref);
                    //     },
                    //     child: const HeroIcon(
                    //       HeroIcons.tableCells,
                    //       size: 25.0,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    if (status == Status.counting || status == Status.published)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialogBox(
                                    title: VoteTextConstants.resetVote,
                                    descriptions: "",
                                    onYes: () async {
                                      tokenExpireWrapper(ref, () async {
                                        final value =
                                            await statusNotifier.resetVote();
                                        ref
                                            .watch(pretendanceListProvider
                                                .notifier)
                                            .loadPretendanceList();
                                        if (value) {
                                          showVotesNotifier.toggle(false);
                                          displayVoteToastWithContext(
                                              TypeMsg.msg, 'Vote is reset');
                                        } else {
                                          displayVoteToastWithContext(
                                              TypeMsg.error, 'Error');
                                        }
                                      });
                                    });
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black,
                          ),
                          child: const Text(VoteTextConstants.clear,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: MediaQuery.of(context).size.height -
                    539 +
                    (status == Status.waiting ? 0 : 50),
                child: Column(
                  children: [
                    if (status == Status.counting)
                      showVotes
                          ? const VoteBars()
                          : GestureDetector(
                              onTap: () {
                                showVotesNotifier.toggle(true);
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  HeroIcon(
                                    HeroIcons.eye,
                                    size: 80.0,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    VoteTextConstants.showVotes,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                    if (status == Status.published)
                      const VoteBars(),
                    if (status == Status.closed)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 50),
                        child: GestureDetector(
                          onTap: () {
                            tokenExpireWrapper(ref, () async {
                              final value = await statusNotifier.countVote();
                              if (value) {
                                displayVoteToastWithContext(
                                    TypeMsg.msg, 'Votes counted');
                              } else {
                                displayVoteToastWithContext(
                                    TypeMsg.error, 'Vote not counted');
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.grey.shade900,
                                      Colors.black
                                    ]),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(3, 3),
                                  )
                                ]),
                            child: const Center(
                              child: Text(
                                VoteTextConstants.countVote,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (status == Status.open)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 50),
                        child: GestureDetector(
                          onTap: () {
                            tokenExpireWrapper(ref, () async {
                              final value = await statusNotifier.closeVote();
                              if (value) {
                                displayVoteToastWithContext(
                                    TypeMsg.msg, 'Vote is closed');
                              } else {
                                displayVoteToastWithContext(
                                    TypeMsg.error, 'Error');
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColorConstants.gradient1,
                                    ColorConstants.gradient2,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstants.gradient2
                                        .withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(3, 3),
                                  )
                                ]),
                            child: const Center(
                              child: Text(
                                VoteTextConstants.closeVote,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (status == Status.waiting)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 50),
                        child: GestureDetector(
                          onTap: () {
                            tokenExpireWrapper(ref, () async {
                              final value = await statusNotifier.openVote();
                              ref
                                  .watch(pretendanceListProvider.notifier)
                                  .loadPretendanceList();
                              if (value) {
                                displayVoteToastWithContext(
                                    TypeMsg.msg, 'Vote is open');
                              } else {
                                displayVoteToastWithContext(
                                    TypeMsg.error, 'Error');
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Colors.grey.shade50,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(3, 3),
                                  )
                                ]),
                            child: const Center(
                              child: Text(
                                VoteTextConstants.openVote,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (status == Status.open)
                        const VoteCount()
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
