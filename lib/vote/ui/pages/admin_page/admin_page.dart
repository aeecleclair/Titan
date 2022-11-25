import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';
import 'package:myecl/vote/providers/pretendance_members.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/sections_votes_provider.dart';
import 'package:myecl/vote/providers/show_graph_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/providers/votes_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/admin_page/pretendance_card.dart';
import 'package:myecl/vote/ui/section_chip.dart';
import 'package:myecl/vote/ui/pages/admin_page/vote_bars.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionPretendance = ref.watch(sectionPretendanceProvider);
    final membersNotifier = ref.watch(pretendanceMembersProvider.notifier);
    final section = ref.watch(sectionProvider);
    final sectionIdNotifier = ref.watch(sectionIdProvider.notifier);
    final pretendanceListNotifier = ref.watch(pretendanceListProvider.notifier);
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final sectionPretendanceListNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final pretendances = ref.watch(pretendanceListProvider);
    final pretendanceNotifier = ref.watch(pretendanceProvider.notifier);
    final asyncStatus = ref.watch(statusProvider);
    final statusNotifier = ref.watch(statusProvider.notifier);
    final sectionsVotesNotifier = ref.watch(sectionsVotesProvider.notifier);
    final votesNotifier = ref.watch(votesProvider.notifier);
    final showVotes = ref.watch(showGraphProvider);
    final showVotesNotifier = ref.watch(showGraphProvider.notifier);
    bool status = false;
    asyncStatus.whenData((value) => status = value);
    ref.watch(userList);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Refresher(
      onRefresh: () async {
        await statusNotifier.loadStatus();
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
          sectionsVotesNotifier.loadTList(value);
          votesNotifier.getVoteById(section.id);
          sectionsVotesNotifier.setTData(section, await votesNotifier.copy());
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            sectionPretendance.when(
                data: (Map<Section, AsyncValue<List<Pretendance>>> sections) =>
                    Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  pageNotifier.setVotePage(VotePage.addSection);
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
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
                                ...sections
                                    .map((key, value) => MapEntry(
                                        SectionChip(
                                            label: capitalize(key.name),
                                            selected: section.id == key.id,
                                            isAdmin: true,
                                            onTap: () async {
                                              tokenExpireWrapper(ref, () async {
                                                sectionIdNotifier.setId(key.id);
                                              });
                                            },
                                            onDelete: () async {
                                              tokenExpireWrapper(ref, () async {
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        CustomDialogBox(
                                                          title:
                                                              'Supprimer la section',
                                                          descriptions:
                                                              'Voulez-vous vraiment supprimer cette section ?',
                                                          onYes: () async {
                                                            final result =
                                                                await sectionsNotifier
                                                                    .deleteSection(
                                                                        key);
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
                                    .keys,
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
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
                        if (sections[section] != null)
                          sections[section]!.when(
                              data: (List<Pretendance> data) =>
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            pageNotifier.setVotePage(
                                                VotePage.addPretendance);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              width: 120,
                                              height: 180,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                    offset: const Offset(3, 3),
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                    offset: const Offset(3, 3),
                                                  ),
                                                ],
                                              ),
                                              child: const Center(
                                                  child: HeroIcon(
                                                HeroIcons.plus,
                                                size: 40.0,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ),
                                        ),
                                        ...data
                                            .map((e) => PretendanceCard(
                                                  pretendance: e,
                                                  isAdmin: true,
                                                  onEdit: () {
                                                    tokenExpireWrapper(ref,
                                                        () async {
                                                      pretendanceNotifier
                                                          .setId(e);
                                                      membersNotifier
                                                          .setMembers(
                                                              e.members);
                                                      pageNotifier.setVotePage(
                                                          VotePage
                                                              .editPretendance);
                                                    });
                                                  },
                                                  onDelete: () {
                                                    tokenExpireWrapper(ref,
                                                        () async {
                                                      final value =
                                                          await pretendanceListNotifier
                                                              .deletePretendance(
                                                                  e);
                                                      if (value) {
                                                        displayVoteToastWithContext(
                                                            TypeMsg.msg,
                                                            VoteTextConstants
                                                                .pretendanceDeleted);
                                                        pretendanceListNotifier
                                                            .copy()
                                                            .then((value) {
                                                          sectionPretendanceListNotifier
                                                              .setTData(section,
                                                                  value);
                                                        });
                                                      } else {
                                                        displayVoteToastWithContext(
                                                            TypeMsg.error,
                                                            VoteTextConstants
                                                                .pretendanceNotDeleted);
                                                      }
                                                    });
                                                  },
                                                ))
                                            .toList(),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                              error: (Object error, StackTrace? stackTrace) {
                                return Center(child: Text('Error $error'));
                              },
                              loading: () {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                ));
                              }),
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
                                        color: Color.fromARGB(
                                            255, 205, 205, 205))),
                                if (showVotes && status)
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
                                if (status)
                                  GestureDetector(
                                    onTap: () {
                                      tokenExpireWrapper(ref, () async {
                                        final value = await statusNotifier
                                            .updateStatus(false);
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
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.black,
                                      ),
                                      child: const Text(
                                          VoteTextConstants.closeVote,
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
                            height: MediaQuery.of(context).size.height - 539,
                            child: showVotes
                                ? status
                                    ? const VoteBars()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          const Center(
                                            child: Text(
                                              VoteTextConstants.voteNotStarted,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 205, 205, 205)),
                                            ),
                                          ),
                                          const SizedBox(height: 50),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                tokenExpireWrapper(ref,
                                                    () async {
                                                  final value =
                                                      await statusNotifier
                                                          .updateStatus(true);
                                                  if (value) {
                                                    displayVoteToastWithContext(
                                                        TypeMsg.msg,
                                                        'Vote started');
                                                  } else {
                                                    displayVoteToastWithContext(
                                                        TypeMsg.error,
                                                        'Vote not started');
                                                  }
                                                });
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 12),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: const Center(
                                                  child: Text(
                                                    VoteTextConstants.openVote,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )
                                : GestureDetector(
                                    onTap: () {
                                      showVotesNotifier.toggle(true);
                                    },
                                    behavior: HitTestBehavior.opaque,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
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
                                  ))
                      ],
                    ),
                error: (Object error, StackTrace? stackTrace) {
                  return Center(child: Text('Error $error'));
                },
                loading: () {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
