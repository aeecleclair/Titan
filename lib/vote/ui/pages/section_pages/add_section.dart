import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/section.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/ui/text_entry.dart';

class AddSectionPage extends HookConsumerWidget {
  const AddSectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionPretendanceNotifier =
        ref.watch(sectionPretendanceProvider.notifier);
    final sectionListNotifier = ref.watch(sectionsProvider.notifier);
    final sections = ref.watch(sectionsProvider);
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return Padding(
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
                      color: Color.fromARGB(255, 205, 205, 205)))),
          Form(
            key: key,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextEntry(
                  controller: name,
                  isInt: false,
                  keyboardType: TextInputType.text,
                  label: VoteTextConstants.sectionName,
                  suffix: '',
                ),
                const SizedBox(
                  height: 30,
                ),
                TextEntry(
                  controller: description,
                  isInt: false,
                  keyboardType: TextInputType.text,
                  label: VoteTextConstants.sectionDescription,
                  suffix: '',
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  child: Container(
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
                      child: const Text(VoteTextConstants.add,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                  onTap: () {
                    tokenExpireWrapper(ref, () async {
                      Section newSection = Section(
                          name: name.text,
                          id: '',
                          description: description.text);
                      final value =
                          await sectionListNotifier.addSection(newSection);
                      if (value) {
                        pageNotifier.setVotePage(VotePage.admin);
                        sections.whenData((value) {
                          sectionPretendanceNotifier.addT(value.last);
                        });
                        displayVoteToastWithContext(
                            TypeMsg.msg, VoteTextConstants.addedSection);
                      } else {
                        displayVoteToastWithContext(
                            TypeMsg.error, VoteTextConstants.addingError);
                      }
                    });
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          )
        ]));
  }
}
