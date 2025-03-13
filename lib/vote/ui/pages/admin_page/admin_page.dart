import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/vote/providers/list_list_provider.dart';
import 'package:myecl/vote/providers/result_provider.dart';
import 'package:myecl/vote/providers/sections_list_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/show_graph_provider.dart';
import 'package:myecl/vote/providers/status_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/pages/admin_page/admin_button.dart';
import 'package:myecl/vote/ui/pages/admin_page/section_bar.dart';
import 'package:myecl/vote/ui/pages/admin_page/section_list_items.dart';
import 'package:myecl/vote/ui/pages/admin_page/vote_bars.dart';
import 'package:myecl/vote/ui/pages/admin_page/vote_count.dart';
import 'package:myecl/vote/ui/pages/admin_page/voters_bar.dart';
import 'package:myecl/vote/ui/vote.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionListListNotifier = ref.watch(sectionListProvider.notifier);
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
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SectionBar(),
              const SizedBox(height: 30),
              const AlignLeftText(
                VoteTextConstants.voters,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                color: Color.fromARGB(255, 149, 149, 149),
              ),
              const SizedBox(height: 30),
              const VotersBar(),
              const SizedBox(height: 30),
              const AlignLeftText(
                VoteTextConstants.pretendance,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              const SectionListItems(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        VoteTextConstants.vote,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
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
                                  color: Colors.black,
                                ),
                              ),
                              WaitingButton(
                                builder: (child) => AdminButton(child: child),
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) => CustomDialogBox(
                                      title: VoteTextConstants.publish,
                                      descriptions: VoteTextConstants
                                          .publishVoteDescription,
                                      onYes: () {
                                        statusNotifier.publishVote();
                                        ref
                                            .watch(resultProvider.notifier)
                                            .loadResult();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  VoteTextConstants.publish,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
                                  title: VoteTextConstants.resetVote,
                                  descriptions:
                                      VoteTextConstants.resetVoteDescription,
                                  onYes: () async {
                                    final value =
                                        await statusNotifier.resetVote();
                                    ref
                                        .watch(
                                          listListProvider.notifier,
                                        )
                                        .loadListList();
                                    if (value) {
                                      showVotesNotifier.toggle(false);
                                      displayVoteToastWithContext(
                                        TypeMsg.msg,
                                        VoteTextConstants.resetedVotes,
                                      );
                                    } else {
                                      displayVoteToastWithContext(
                                        TypeMsg.error,
                                        VoteTextConstants.errorResetingVotes,
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: const Text(
                            VoteTextConstants.clear,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    500 +
                    (status.status == StatusType.waiting ? 0 : 50),
                child: Column(
                  children: [
                    if (status.status == StatusType.counting)
                      showVotes
                          ? const VoteBars()
                          : GestureDetector(
                              onTap: () {
                                showVotesNotifier.toggle(true);
                              },
                              behavior: HitTestBehavior.opaque,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                      color: Colors.black,
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
                          builder: (child) => CardLayout(
                            padding: const EdgeInsets.only(top: 10, bottom: 12),
                            width: double.infinity,
                            colors: [Colors.grey.shade900, Colors.black],
                            child: child,
                          ),
                          onTap: () async {
                            final value = await statusNotifier.countVote();
                            if (value) {
                              displayVoteToastWithContext(
                                TypeMsg.msg,
                                VoteTextConstants.votesCounted,
                              );
                            } else {
                              displayVoteToastWithContext(
                                TypeMsg.error,
                                VoteTextConstants.errorCountingVotes,
                              );
                            }
                          },
                          child: const Center(
                            child: Text(
                              VoteTextConstants.countVote,
                              style: TextStyle(
                                color: Colors.white,
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
                          builder: (child) => CardLayout(
                            padding: const EdgeInsets.only(top: 10, bottom: 12),
                            width: double.infinity,
                            colors: const [
                              ColorConstants.gradient1,
                              ColorConstants.gradient2,
                            ],
                            child: child,
                          ),
                          onTap: () async {
                            final value = await statusNotifier.closeVote();
                            if (value) {
                              displayVoteToastWithContext(
                                TypeMsg.msg,
                                VoteTextConstants.votesClosed,
                              );
                            } else {
                              displayVoteToastWithContext(
                                TypeMsg.error,
                                VoteTextConstants.errorClosingVotes,
                              );
                            }
                          },
                          child: const Center(
                            child: Text(
                              VoteTextConstants.closeVote,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (status.status == StatusType.waiting)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 50,
                          ),
                          child: Column(
                            children: [
                              WaitingButton(
                                waitingColor: Colors.black,
                                builder: (child) => CardLayout(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 12,
                                  ),
                                  margin: const EdgeInsets.all(0),
                                  color: Colors.white,
                                  borderColor: Colors.black,
                                  child: child,
                                ),
                                onTap: () async {
                                  final value = await statusNotifier.openVote();
                                  ref
                                      .watch(listListProvider.notifier)
                                      .loadListList();
                                  if (value) {
                                    displayVoteToastWithContext(
                                      TypeMsg.msg,
                                      VoteTextConstants.votesOpened,
                                    );
                                  } else {
                                    displayVoteToastWithContext(
                                      TypeMsg.error,
                                      VoteTextConstants.errorOpeningVotes,
                                    );
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    VoteTextConstants.openVote,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: WaitingButton(
                                        builder: (child) => CardLayout(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 12,
                                          ),
                                          margin: const EdgeInsets.all(0),
                                          colors: const [
                                            AMAPColorConstants.redGradient1,
                                            AMAPColorConstants.redGradient2,
                                          ],
                                          borderColor: Colors.white,
                                          child: child,
                                        ),
                                        onTap: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomDialogBox(
                                              title:
                                                  VoteTextConstants.deleteAll,
                                              descriptions: VoteTextConstants
                                                  .deleteAllDescription,
                                              onYes: () async {
                                                final value = await ref
                                                    .watch(
                                                      listListProvider.notifier,
                                                    )
                                                    .deleteLists();
                                                if (value) {
                                                  displayVoteToastWithContext(
                                                    TypeMsg.msg,
                                                    VoteTextConstants
                                                        .deletedAll,
                                                  );
                                                } else {
                                                  displayVoteToastWithContext(
                                                    TypeMsg.error,
                                                    VoteTextConstants
                                                        .deletingError,
                                                  );
                                                }
                                              },
                                            ),
                                          );
                                        },
                                        child: const Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                VoteTextConstants.all,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              HeroIcon(
                                                HeroIcons.trash,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: WaitingButton(
                                        builder: (child) => CardLayout(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 12,
                                          ),
                                          margin: const EdgeInsets.all(0),
                                          colors: const [
                                            AMAPColorConstants.redGradient1,
                                            AMAPColorConstants.redGradient2,
                                          ],
                                          borderColor: Colors.white,
                                          child: child,
                                        ),
                                        onTap: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomDialogBox(
                                              title:
                                                  VoteTextConstants.deletePipo,
                                              descriptions: VoteTextConstants
                                                  .deletePipoDescription,
                                              onYes: () async {
                                                final value = await ref
                                                    .watch(
                                                      listListProvider.notifier,
                                                    )
                                                    .deleteLists(
                                                      type: ListType.pipo,
                                                    );
                                                if (value) {
                                                  displayVoteToastWithContext(
                                                    TypeMsg.msg,
                                                    VoteTextConstants
                                                        .deletedPipo,
                                                  );
                                                } else {
                                                  displayVoteToastWithContext(
                                                    TypeMsg.error,
                                                    VoteTextConstants
                                                        .deletingError,
                                                  );
                                                }
                                              },
                                            ),
                                          );
                                        },
                                        child: const Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                VoteTextConstants.pipo,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              HeroIcon(
                                                HeroIcons.trash,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (status.status == StatusType.open) const VoteCount(),
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
