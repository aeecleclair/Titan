import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/can_vote_provider.dart';
import 'package:titan/vote/providers/is_vote_admin_provider.dart';
import 'package:titan/vote/providers/contender_list_provider.dart';
import 'package:titan/vote/providers/contender_logo_provider.dart';
import 'package:titan/vote/providers/contender_logos_provider.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/providers/voted_section_provider.dart';
import 'package:titan/vote/repositories/status_repository.dart';
import 'package:titan/vote/router.dart';
import 'package:titan/vote/ui/pages/main_page/list_contender_card.dart';
import 'package:titan/vote/ui/pages/main_page/list_side_item.dart';
import 'package:titan/vote/ui/pages/main_page/section_title.dart';
import 'package:titan/vote/ui/pages/main_page/vote_button.dart';
import 'package:titan/vote/ui/vote.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class VoteMainPage extends HookConsumerWidget {
  const VoteMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusNotifier = ref.watch(statusProvider.notifier);
    final isAdmin = ref.watch(isVoteAdminProvider);
    final sections = ref.watch(sectionsProvider);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final contenders = ref.watch(contenderListProvider);
    final contendersNotifier = ref.watch(contenderListProvider.notifier);
    final sectionContenderNotifier = ref.watch(
      sectionContenderProvider.notifier,
    );
    final animation = useAnimationController(
      duration: const Duration(milliseconds: 2400),
    );
    final status = ref.watch(statusProvider);
    final s = status.maybeWhen(
      data: (value) => value,
      orElse: () => Status.closed,
    );
    if (s == Status.open) {
      ref.watch(votedSectionProvider.notifier).getVotedSections();
    }
    final logosNotifier = ref.watch(contenderLogoProvider.notifier);
    final contenderLogosNotifier = ref.watch(contenderLogosProvider.notifier);

    final canVote = ref.watch(canVoteProvider);

    if (!canVote) {
      return VoteTemplate(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  if (isAdmin)
                    Text(
                      "Vote",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.title,
                      ),
                    ),
                  const Spacer(),
                  CustomIconButton(
                    icon: HeroIcon(
                      HeroIcons.userGroup,
                      color: ColorConstants.background,
                    ),
                    onPressed: () {
                      QR.to(VoteRouter.root + VoteRouter.admin);
                    },
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.voteCanNotVote,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return VoteTemplate(
      child: Refresher(
        controller: ScrollController(),
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
            contenderLogosNotifier.loadTList(
              list.map((contender) => contender.id).toList(),
            );
            for (final l in value) {
              sectionContenderNotifier.setTData(
                l,
                AsyncValue.data(
                  list.where((element) => element.section.id == l.id).toList(),
                ),
              );
            }
            for (final contender in list) {
              logosNotifier
                  .getLogo(contender.id)
                  .then(
                    (value) => contenderLogosNotifier.setTData(
                      contender.id,
                      AsyncValue.data([value]),
                    ),
                  );
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Vote",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
              AsyncChild(
                value: sections,
                builder: (context, sectionList) => Column(
                  children: [
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height -
                          (s == Status.open ? 220 : 155),
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
                                      SectionTitle(sectionList: sectionList),
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
                                    child: ListContenderCard(
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
                    if (sectionList.isNotEmpty && s == Status.open)
                      const VoteButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
