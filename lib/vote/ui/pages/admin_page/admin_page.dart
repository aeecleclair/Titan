import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/generated/openapi.enums.swagger.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/vote/providers/list_list_provider.dart';
import 'package:titan/vote/providers/list_members.dart';
import 'package:titan/vote/providers/list_provider.dart';
import 'package:titan/vote/providers/result_provider.dart';
import 'package:titan/vote/providers/sections_list_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/show_graph_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/router.dart';
import 'package:titan/vote/ui/pages/admin_page/admin_button.dart';
import 'package:titan/vote/ui/pages/admin_page/opening_vote.dart';
import 'package:titan/vote/ui/pages/admin_page/section_bar.dart';
import 'package:titan/vote/ui/pages/admin_page/section_list_items.dart';
import 'package:titan/vote/ui/pages/admin_page/vote_bars.dart';
import 'package:titan/vote/ui/pages/admin_page/vote_count.dart';
import 'package:titan/vote/ui/vote.dart';
import 'package:titan/l10n/app_localizations.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionListListNotifier = ref.watch(sectionListProvider.notifier);
    final membersNotifier = ref.read(listMembersProvider.notifier);
    final listNotifier = ref.read(listProvider.notifier);
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final listList = ref.watch(listListProvider);
    final asyncStatus = ref.watch(statusProvider);
    final statusNotifier = ref.watch(statusProvider.notifier);
    final showVotes = ref.watch(showGraphProvider);
    final showVotesNotifier = ref.watch(showGraphProvider.notifier);
    VoteStatus status = VoteStatus(status: StatusType.open);
    asyncStatus.whenData((value) => status = value);
    ref.watch(userList);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return VoteTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await statusNotifier.loadStatus();
          if (status.status == StatusType.counting ||
              status.status == StatusType.published) {
            await ref.watch(resultProvider.notifier).loadResult();
          }
          final sections = await sectionsNotifier.loadSectionList();
          sections.whenData((value) async {
            List<ListReturn> list = [];
            listList.maybeWhen(
              data: (lists) {
                list = lists;
              },
              orElse: () {
                list = [];
              },
            );
            sectionListListNotifier.loadTList(value);
            for (final l in value) {
              sectionListListNotifier.setTData(
                l,
                AsyncValue.data(
                  list.where((element) => element.section.id == l.id).toList(),
                ),
              );
            }
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                AppLocalizations.of(context)!.adminAdministration,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.title,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AlignLeftText(
              AppLocalizations.of(context)!.feedAssociation,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: ColorConstants.tertiary,
            ),
            const SizedBox(height: 10),
            const SectionBar(),
            const SizedBox(height: 20),
            AlignLeftText(
              AppLocalizations.of(context)!.voteVoters,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: ColorConstants.tertiary,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.votePretendance,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.tertiary,
                    ),
                  ),
                  const Spacer(),
                  if (status.status == StatusType.waiting)
                    CustomIconButton(
                      icon: HeroIcon(
                        HeroIcons.plus,
                        color: ColorConstants.background,
                      ),
                      onPressed: () {
                        listNotifier.setId(ListReturn.fromJson({}));
                        membersNotifier.setMembers([]);
                        QR.to(
                          VoteRouter.root +
                              VoteRouter.admin +
                              VoteRouter.addEditList,
                        );
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const SectionListItems(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.voteVote,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.tertiary,
                      ),
                    ),
                    if (showVotes && status.status == StatusType.counting)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showVotesNotifier.toggle(false);
                              },
                              child: const HeroIcon(
                                HeroIcons.eyeSlash,
                                size: 25.0,
                                color: ColorConstants.tertiary,
                              ),
                            ),
                            WaitingButton(
                              builder: (child) => AdminButton(child: child),
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => CustomDialogBox(
                                    title: AppLocalizations.of(
                                      context,
                                    )!.votePublish,
                                    descriptions: AppLocalizations.of(
                                      context,
                                    )!.votePublishVoteDescription,
                                    onYes: () {
                                      statusNotifier.publishVote();
                                      ref
                                          .watch(resultProvider.notifier)
                                          .loadResult();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.votePublish,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.background,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (status.status == StatusType.counting ||
                        status.status == StatusType.published)
                      WaitingButton(
                        builder: (child) => AdminButton(child: child),
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialogBox(
                                title: AppLocalizations.of(
                                  context,
                                )!.voteResetVote,
                                descriptions: AppLocalizations.of(
                                  context,
                                )!.voteResetVoteDescription,
                                onYes: () async {
                                  final resetedVotesMsg = AppLocalizations.of(
                                    context,
                                  )!.voteResetedVotes;
                                  final resetedVotesErrorMsg =
                                      AppLocalizations.of(
                                        context,
                                      )!.voteErrorResetingVotes;
                                  final value = await statusNotifier
                                      .resetVote();
                                  ref
                                      .watch(listListProvider.notifier)
                                      .loadListList();
                                  if (value) {
                                    showVotesNotifier.toggle(false);
                                    displayVoteToastWithContext(
                                      TypeMsg.msg,
                                      resetedVotesMsg,
                                    );
                                  } else {
                                    displayVoteToastWithContext(
                                      TypeMsg.error,
                                      resetedVotesErrorMsg,
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.voteClear,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.background,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                if (status.status == StatusType.counting)
                  showVotes
                      ? const VoteBars()
                      : GestureDetector(
                          onTap: () {
                            showVotesNotifier.toggle(true);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              const HeroIcon(
                                HeroIcons.eye,
                                size: 80.0,
                                color: ColorConstants.tertiary,
                              ),
                              const SizedBox(height: 40),
                              Text(
                                AppLocalizations.of(context)!.voteShowVotes,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                if (status.status == StatusType.published) const VoteBars(),
                if (status.status == StatusType.closed)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 50,
                    ),
                    child: WaitingButton(
                      builder: (child) => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.tertiary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorConstants.onTertiary),
                        ),
                        child: child,
                      ),
                      onTap: () async {
                        final votesCountedMsg = AppLocalizations.of(
                          context,
                        )!.voteVotesCounted;
                        final errorCountingVotesMsg = AppLocalizations.of(
                          context,
                        )!.voteErrorCountingVotes;
                        final value = await statusNotifier.countVote();
                        if (value) {
                          displayVoteToastWithContext(
                            TypeMsg.msg,
                            votesCountedMsg,
                          );
                        } else {
                          displayVoteToastWithContext(
                            TypeMsg.error,
                            errorCountingVotesMsg,
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.voteCountVote,
                          style: const TextStyle(
                            color: ColorConstants.background,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (status.status == StatusType.open)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 50,
                    ),
                    child: WaitingButton(
                      builder: (child) => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.main,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorConstants.mainBorder),
                        ),
                        child: child,
                      ),
                      onTap: () async {
                        final closeVotesMsg = AppLocalizations.of(
                          context,
                        )!.voteVotesClosed;
                        final errorClosingVotesMsg = AppLocalizations.of(
                          context,
                        )!.voteErrorClosingVotes;
                        final value = await statusNotifier.closeVote();
                        if (value) {
                          displayVoteToastWithContext(
                            TypeMsg.msg,
                            closeVotesMsg,
                          );
                        } else {
                          displayVoteToastWithContext(
                            TypeMsg.error,
                            errorClosingVotesMsg,
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.voteCloseVote,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (status.status == StatusType.waiting) const OpeningVote(),
                if (status.status == StatusType.open) const VoteCount(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
