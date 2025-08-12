import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/contender_list_provider.dart';
import 'package:titan/vote/providers/result_provider.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/providers/show_graph_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';
import 'package:titan/vote/repositories/status_repository.dart';
import 'package:titan/vote/ui/pages/admin_page/admin_button.dart';
import 'package:titan/vote/ui/pages/admin_page/section_bar.dart';
import 'package:titan/vote/ui/pages/admin_page/section_contender_items.dart';
import 'package:titan/vote/ui/pages/admin_page/vote_bars.dart';
import 'package:titan/vote/ui/pages/admin_page/vote_count.dart';
import 'package:titan/vote/ui/pages/admin_page/voters_bar.dart';
import 'package:titan/vote/ui/vote.dart';
import 'package:titan/l10n/app_localizations.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionContenderListNotifier = ref.watch(
      sectionContenderProvider.notifier,
    );
    final sectionsNotifier = ref.watch(sectionsProvider.notifier);
    final contenderList = ref.watch(contenderListProvider);
    final asyncStatus = ref.watch(statusProvider);
    final statusNotifier = ref.watch(statusProvider.notifier);
    final showVotes = ref.watch(showGraphProvider);
    final showVotesNotifier = ref.watch(showGraphProvider.notifier);
    Status status = Status.open;
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
          if (status == Status.counting || status == Status.published) {
            await ref.watch(resultProvider.notifier).loadResult();
          }
          final sections = await sectionsNotifier.loadSectionList();
          sections.whenData((value) async {
            List<Contender> list = [];
            contenderList.maybeWhen(
              data: (contenders) {
                list = contenders;
              },
              orElse: () {
                list = [];
              },
            );
            sectionContenderListNotifier.loadTList(value);
            for (final l in value) {
              sectionContenderListNotifier.setTData(
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
              AlignLeftText(
                AppLocalizations.of(context)!.voteVoters,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                color: const Color.fromARGB(255, 149, 149, 149),
              ),
              const SizedBox(height: 30),
              const VotersBar(),
              const SizedBox(height: 30),
              AlignLeftText(
                AppLocalizations.of(context)!.votePretendance,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              const SectionContenderItems(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                          color: Colors.grey,
                        ),
                      ),
                      if (showVotes && status == Status.counting)
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
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (status == Status.counting ||
                          status == Status.published)
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
                                    await tokenExpireWrapper(ref, () async {
                                      final resetedVotesMsg =
                                          AppLocalizations.of(
                                            context,
                                          )!.voteResetedVotes;
                                      final resetedVotesErrorMsg =
                                          AppLocalizations.of(
                                            context,
                                          )!.voteErrorResetingVotes;
                                      final value = await statusNotifier
                                          .resetVote();
                                      ref
                                          .watch(contenderListProvider.notifier)
                                          .loadContenderList();
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
                                    });
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
                height:
                    MediaQuery.of(context).size.height -
                    500 +
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
                                children: [
                                  const SizedBox(height: 40),
                                  const HeroIcon(
                                    HeroIcons.eye,
                                    size: 80.0,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    AppLocalizations.of(context)!.voteShowVotes,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    if (status == Status.published) const VoteBars(),
                    if (status == Status.closed)
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
                            await tokenExpireWrapper(ref, () async {
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
                            });
                          },
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.voteCountVote,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (status == Status.open)
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
                            await tokenExpireWrapper(ref, () async {
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
                            });
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
                    if (status == Status.waiting)
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
                                  await tokenExpireWrapper(ref, () async {
                                    final openVotesMsg = AppLocalizations.of(
                                      context,
                                    )!.voteVotesOpened;
                                    final errorOpeningVotesMsg =
                                        AppLocalizations.of(
                                          context,
                                        )!.voteErrorOpeningVotes;
                                    final value = await statusNotifier
                                        .openVote();
                                    ref
                                        .watch(contenderListProvider.notifier)
                                        .loadContenderList();
                                    if (value) {
                                      displayVoteToastWithContext(
                                        TypeMsg.msg,
                                        openVotesMsg,
                                      );
                                    } else {
                                      displayVoteToastWithContext(
                                        TypeMsg.error,
                                        errorOpeningVotesMsg,
                                      );
                                    }
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.voteOpenVote,
                                    style: const TextStyle(
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
                                            builder: (context) => CustomDialogBox(
                                              title: AppLocalizations.of(
                                                context,
                                              )!.voteDeleteAll,
                                              descriptions: AppLocalizations.of(
                                                context,
                                              )!.voteDeleteAllDescription,
                                              onYes: () async {
                                                final deleteAllVotesMsg =
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.voteDeletedAll;
                                                final errorDeletingVotesMsg =
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.voteDeletingError;
                                                await tokenExpireWrapper(
                                                  ref,
                                                  () async {
                                                    final value = await ref
                                                        .watch(
                                                          contenderListProvider
                                                              .notifier,
                                                        )
                                                        .deleteContenders();
                                                    if (value) {
                                                      displayVoteToastWithContext(
                                                        TypeMsg.msg,
                                                        deleteAllVotesMsg,
                                                      );
                                                    } else {
                                                      displayVoteToastWithContext(
                                                        TypeMsg.error,
                                                        errorDeletingVotesMsg,
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.voteAll,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const HeroIcon(
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
                                            builder: (context) => CustomDialogBox(
                                              title: AppLocalizations.of(
                                                context,
                                              )!.voteDeletePipo,
                                              descriptions: AppLocalizations.of(
                                                context,
                                              )!.voteDeletePipoDescription,
                                              onYes: () async {
                                                final deletePipoVotesMsg =
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.voteDeletedPipo;
                                                final errorDeletingPipoVotesMsg =
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.voteDeletingError;
                                                await tokenExpireWrapper(
                                                  ref,
                                                  () async {
                                                    final value = await ref
                                                        .watch(
                                                          contenderListProvider
                                                              .notifier,
                                                        )
                                                        .deleteContenders(
                                                          type: ListType.fake,
                                                        );
                                                    if (value) {
                                                      displayVoteToastWithContext(
                                                        TypeMsg.msg,
                                                        deletePipoVotesMsg,
                                                      );
                                                    } else {
                                                      displayVoteToastWithContext(
                                                        TypeMsg.error,
                                                        errorDeletingPipoVotesMsg,
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.votePipo,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const HeroIcon(
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
                    if (status == Status.open) const VoteCount(),
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
