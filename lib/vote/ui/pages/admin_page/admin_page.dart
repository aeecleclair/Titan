import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/section_id_provider.dart';
import 'package:myecl/vote/providers/section_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/tools/functions.dart';
import 'package:myecl/vote/ui/pages/admin_page/pretendance_card.dart';
import 'package:myecl/vote/ui/section_chip.dart';
import 'package:myecl/vote/ui/pages/admin_page/vote_bars.dart';
import 'package:myecl/vote/ui/refresh_indicator.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionPretendance = ref.watch(sectionPretendanceProvider);
    final section = ref.watch(sectionProvider);
    final sectionList = ref.watch(sectionsProvider);
    final sectionIdNotifier = ref.watch(sectionIdProvider.notifier);
    final pretendanceNotifier = ref.watch(pretendanceProvider.notifier);
    final loaded = useState(false);
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final sectionPretendanceNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayVoteToast(context, type, msg);
    }

    if (!loaded.value) {
      // pretendanceNotifier.loadPretendanceListBySection(section.id);
      pretendanceNotifier.copy().then(
        (value) {
          sectionPretendanceNotifier.setTData(section, value);
        },
      );
      loaded.value = true;
    }
    return VoteRefresher(
      onRefresh: () async {
        // pretendanceNotifier.loadPretendanceListBySection(section.id);
        sectionPretendanceNotifier.setTData(
            section, await pretendanceNotifier.copy());
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
                                          onTap: () async {
                                            sectionIdNotifier.setId(key.id);
                                            sectionPretendance.whenData(
                                              (value) async {
                                                if (value[key] != null) {
                                                  value[key]!
                                                      .whenData((value) async {
                                                    if (value.isEmpty) {
                                                      pretendanceNotifier
                                                          .loadPretendanceListBySection(
                                                              key.id);
                                                      sectionPretendanceNotifier
                                                          .setTData(
                                                              key,
                                                              await pretendanceNotifier
                                                                  .copy());
                                                    }
                                                  });
                                                } else {
                                                  pretendanceNotifier
                                                      .loadPretendanceListBySection(
                                                          key.id);
                                                  sectionPretendanceNotifier
                                                      .setTData(
                                                          key,
                                                          await pretendanceNotifier
                                                              .copy());
                                                }
                                              },
                                            );
                                          },
                                        ),
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
                                                  onEdit: () {},
                                                  onCalendar: () {},
                                                  onReturn: () async {},
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(VoteTextConstants.vote,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 205, 205, 205))),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                            height: MediaQuery.of(context).size.height - 530,
                            child: const VoteBars())
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
