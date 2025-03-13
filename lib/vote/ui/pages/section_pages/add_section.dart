import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:myecl/vote/providers/sections_list_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/vote.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddSectionPage extends HookConsumerWidget {
  const AddSectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionListNotifier = ref.read(sectionListProvider.notifier);
    final sectionsNotifier = ref.read(sectionsProvider.notifier);
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
            const AlignLeftText(
              VoteTextConstants.addSection,
              color: Colors.grey,
            ),
            Form(
              key: key,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  TextEntry(
                    controller: name,
                    label: VoteTextConstants.sectionName,
                  ),
                  const SizedBox(height: 30),
                  TextEntry(
                    controller: description,
                    label: VoteTextConstants.sectionDescription,
                  ),
                  const SizedBox(height: 50),
                  WaitingButton(
                    builder: (child) => AddEditButtonLayout(child: child),
                    onTap: () async {
                      final value = await sectionsNotifier.addSection(
                        SectionBase(
                          name: name.text,
                          description: description.text,
                        ),
                      );
                      if (value) {
                        QR.back();
                        sections.whenData((value) {
                          sectionListNotifier.addT(value.last);
                        });
                        displayVoteToastWithContext(
                          TypeMsg.msg,
                          VoteTextConstants.addedSection,
                        );
                      } else {
                        displayVoteToastWithContext(
                          TypeMsg.error,
                          VoteTextConstants.addingError,
                        );
                      }
                    },
                    child: const Text(
                      VoteTextConstants.add,
                      style: TextStyle(
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
