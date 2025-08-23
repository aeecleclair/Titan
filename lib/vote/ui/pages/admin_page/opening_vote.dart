import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/vote/class/contender.dart';
import 'package:titan/vote/providers/contender_list_provider.dart';
import 'package:titan/vote/providers/status_provider.dart';

class OpeningVote extends ConsumerWidget {
  const OpeningVote({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusNotifier = ref.watch(statusProvider.notifier);

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          WaitingButton(
            waitingColor: ColorConstants.background,
            builder: (child) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstants.tertiary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstants.onTertiary),
              ),
              child: child,
            ),
            onTap: () async {
              await tokenExpireWrapper(ref, () async {
                final openVotesMsg = AppLocalizations.of(
                  context,
                )!.voteVotesOpened;
                final errorOpeningVotesMsg = AppLocalizations.of(
                  context,
                )!.voteErrorOpeningVotes;
                final value = await statusNotifier.openVote();
                ref.watch(contenderListProvider.notifier).loadContenderList();
                if (value) {
                  displayVoteToastWithContext(TypeMsg.msg, openVotesMsg);
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
                  color: ColorConstants.background,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          WaitingButton(
            builder: (child) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstants.main,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstants.mainBorder),
              ),
              child: child,
            ),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => CustomDialogBox(
                  title: AppLocalizations.of(context)!.voteDeleteAll,
                  descriptions: AppLocalizations.of(
                    context,
                  )!.voteDeleteAllDescription,
                  onYes: () async {
                    final deleteAllVotesMsg = AppLocalizations.of(
                      context,
                    )!.voteDeletedAll;
                    final errorDeletingVotesMsg = AppLocalizations.of(
                      context,
                    )!.voteDeletingError;
                    await tokenExpireWrapper(ref, () async {
                      final value = await ref
                          .watch(contenderListProvider.notifier)
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
                    });
                  },
                ),
              );
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.voteAll,
                    style: const TextStyle(
                      color: ColorConstants.background,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const HeroIcon(
                    HeroIcons.trash,
                    color: ColorConstants.background,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          WaitingButton(
            builder: (child) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstants.main,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstants.mainBorder),
              ),
              child: child,
            ),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => CustomDialogBox(
                  title: AppLocalizations.of(context)!.voteDeletePipo,
                  descriptions: AppLocalizations.of(
                    context,
                  )!.voteDeletePipoDescription,
                  onYes: () async {
                    final deletePipoVotesMsg = AppLocalizations.of(
                      context,
                    )!.voteDeletedPipo;
                    final errorDeletingPipoVotesMsg = AppLocalizations.of(
                      context,
                    )!.voteDeletingError;
                    await tokenExpireWrapper(ref, () async {
                      final value = await ref
                          .watch(contenderListProvider.notifier)
                          .deleteContenders(type: ListType.fake);
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
                    });
                  },
                ),
              );
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.votePipo,
                    style: const TextStyle(
                      color: ColorConstants.background,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const HeroIcon(
                    HeroIcons.trash,
                    color: ColorConstants.background,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
