import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/align_left_text.dart';
import 'package:myecl/tools/ui/shrink_button.dart';
import 'package:myecl/tools/ui/text_entry.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/sections_contender_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/vote.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddSectionPage extends HookConsumerWidget {
  const AddSectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionContenderNotifier =
        ref.read(sectionContenderProvider.notifier);
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
          child: Column(children: [
            const SizedBox(height: 50),
            const AlignLeftText(VoteTextConstants.addSection,
                color: Color.fromARGB(255, 149, 149, 149)),
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
                  ShrinkButton(
                    builder: (child) => AddEditButtonLayout(child: child),
                    onTap: () async {
                      await tokenExpireWrapper(ref, () async {
                        final value = await sectionListNotifier.addSection(
                            Section(
                                name: name.text,
                                id: '',
                                description: description.text));
                        if (value) {
                          QR.back();
                          sections.whenData((value) {
                            sectionContenderNotifier.addT(value.last);
                          });
                          displayVoteToastWithContext(
                              TypeMsg.msg, VoteTextConstants.addedSection);
                        } else {
                          displayVoteToastWithContext(
                              TypeMsg.error, VoteTextConstants.addingError);
                        }
                      });
                    },
                    child: const Text(VoteTextConstants.add,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            )
          ])),
    );
  }
}
