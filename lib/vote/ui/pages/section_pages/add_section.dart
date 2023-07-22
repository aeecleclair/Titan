import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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
            const SizedBox(
              height: 50,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(VoteTextConstants.addSection,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 149, 149)))),
            Form(
              key: key,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextEntry(
                    controller: name,
                    label: VoteTextConstants.sectionName,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextEntry(
                    controller: description,
                    label: VoteTextConstants.sectionDescription,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ShrinkButton(
                    builder: (child) => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(
                                  3, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: child),
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
