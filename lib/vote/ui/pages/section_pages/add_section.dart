import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/vote/class/section.dart';
import 'package:titan/vote/providers/sections_contender_provider.dart';
import 'package:titan/vote/providers/sections_provider.dart';
import 'package:titan/vote/ui/vote.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AddSectionPage extends HookConsumerWidget {
  const AddSectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionContenderNotifier = ref.read(
      sectionContenderProvider.notifier,
    );
    final sectionListNotifier = ref.read(sectionsProvider.notifier);
    final sections = ref.watch(sectionsProvider);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return VoteTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 50),
            AlignLeftText(
              AppLocalizations.of(context)!.voteAddSection,
              color: Colors.grey,
            ),
            Form(
              key: key,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  TextEntry(
                    controller: name,
                    label: AppLocalizations.of(context)!.voteSectionName,
                  ),
                  const SizedBox(height: 30),
                  TextEntry(
                    controller: description,
                    label: AppLocalizations.of(context)!.voteSectionDescription,
                  ),
                  const SizedBox(height: 50),
                  WaitingButton(
                    builder: (child) => AddEditButtonLayout(child: child),
                    onTap: () async {
                      final addedSectionMsg = AppLocalizations.of(
                        context,
                      )!.voteAddedSection;
                      final addingErrorMsg = AppLocalizations.of(
                        context,
                      )!.voteAddingError;
                      await tokenExpireWrapper(ref, () async {
                        final value = await sectionListNotifier.addSection(
                          Section(
                            name: name.text,
                            id: '',
                            description: description.text,
                          ),
                        );
                        if (value) {
                          QR.back();
                          sections.whenData((value) {
                            sectionContenderNotifier.addT(value.last);
                          });
                          displayVoteToastWithContext(
                            TypeMsg.msg,
                            addedSectionMsg,
                          );
                        } else {
                          displayVoteToastWithContext(
                            TypeMsg.error,
                            addingErrorMsg,
                          );
                        }
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.voteAdd,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
