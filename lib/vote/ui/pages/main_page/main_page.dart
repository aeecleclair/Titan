import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/vote/class/contender.dart';
import 'package:myecl/vote/providers/is_ae_member_provider.dart';
import 'package:myecl/vote/providers/is_vote_admin_provider.dart';
import 'package:myecl/vote/providers/contender_list_provider.dart';
import 'package:myecl/vote/providers/contender_logo_provider.dart';
import 'package:myecl/vote/providers/contender_logos_provider.dart';
import 'package:myecl/vote/providers/sections_contender_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/providers/voted_section_provider.dart';
import 'package:myecl/vote/repositories/status_repository.dart';
import 'package:myecl/vote/router.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/main_page/list_contender_card.dart';
import 'package:myecl/vote/ui/pages/main_page/list_side_item.dart';
import 'package:myecl/vote/ui/pages/main_page/section_title.dart';
import 'package:myecl/vote/ui/pages/main_page/vote_button.dart';
import 'package:myecl/vote/ui/vote.dart';
import 'package:qlevar_router/qlevar_router.dart';

class VoteMainPage extends HookConsumerWidget {
  const VoteMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusNotifier = ref.watch(statusProvider.notifier);
    final isAdmin = ref.watch(isVoteAdminProvider);
    final sections = ref.watch(sectionsProvider);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final sectionsContenders = ref.watch(sectionContenderProvider);
    final contenders = ref.watch(contenderListProvider);
    final contendersNotifier = ref.watch(contenderListProvider.notifier);
    final sectionContenderNotifier =
        ref.watch(sectionContenderProvider.notifier);
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
    final logosNotifier = ref.watch(contenderLogoProvider.notifier);
    final contenderLogosNotifier =
        ref.watch(contenderLogosProvider.notifier);

    final isAEMember = ref.watch(isAEMemberProvider);

    if (isAEMember) {
      return VoteTemplate(
        child: Refresher(
          onRefresh: () async {
            await statusNotifier.loadStatus();
            if (s == Status.open) {
              await ref.watch(votedSectionProvider.notifier).getVotedSections();
            }
            await contendersNotifier.loadContenderList();
            final sections = await sectionsNotifier.loadSectionList();
            sections.whenData((value) {
              List<Contender> list = [];
              contenders.whenData((contender) {
                list = contender;
              });
              sectionContenderNotifier.loadTList(value);
              contenderLogosNotifier.loadTList(list);
              for (final l in value) {
                sectionContenderNotifier.setTData(
                    l,
                    AsyncValue.data(list
                        .where((element) => element.section.id == l.id)
                        .toList()));
              }
              for (final l in list) {
                logosNotifier.getLogo(l.id).then((value) =>
                    contenderLogosNotifier.setTData(
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
                              (s == Status.open
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
                                  sectionList: sectionList, animation: animation),
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: sectionsContenders.when(
                                    data: (contenderList) => Column(children: [
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
                                                  QR.to(VoteRouter.root +
                                                      VoteRouter.admin);
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
                                                  child: const Row(
                                                    children: [
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
                                          child: ListContenderCard(
                                        animation: animation,
                                      ))
                                    ]),
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    error: (error, stack) => Center(
                                      child: Text('Error : $error'),
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
                        if (sectionList.isNotEmpty && s == Status.open)
                          const VoteButton(),
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
    } else {
      return VoteTemplate(
        child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Center(
                  child: Text(
                    VoteTextConstants.notAEMember,
                    style: TextStyle(fontSize: 20),
                  ),
                ))),
      );
    }
  }
}
