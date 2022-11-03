import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:myecl/vote/class/members.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_provider.dart';
import 'package:myecl/vote/providers/section_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:myecl/vote/providers/vote_page_provider.dart';
import 'package:myecl/vote/tools/constants.dart';
import 'package:myecl/vote/tools/functions.dart';
import 'package:myecl/vote/ui/section_chip.dart';
import 'package:myecl/vote/ui/text_entry.dart';

class AddPretendancePage extends HookConsumerWidget {
  const AddPretendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(votePageProvider.notifier);
    final key = GlobalKey<FormState>();
    final section = useState(ref.watch(sectionProvider));
    final sections = ref.watch(sectionsProvider);
    final pretendanceListNotifier = ref.watch(pretendanceProvider.notifier);
    final sectionsNotifier = ref.watch(sectionPretendanceProvider.notifier);
    final name = useTextEditingController();
    final description = useTextEditingController();
    final listType = useState(ListType.serio);
    final users = useState(ref.watch(userList));
    final usersNotifier = ref.watch(userList.notifier);
    final focus = useState(false);
    final queryController = useTextEditingController();
    final lastQuery = useState('');
    final member = useState(Member.empty());
    final members = useState<List<Member>>([]);
    final displayUserSearch = useState(false);
    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayVoteToast(context, type, msg);
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(VoteTextConstants.addPretendance,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 205, 205, 205)))),
            ),
            const SizedBox(height: 30),
            sections.when(
                data: (data) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 15),
                          ...data.map(
                            (e) => SectionChip(
                              label: capitalize(e.name),
                              selected: section.value.id == e.id,
                              onTap: () async {
                                section.value = e;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                error: (Object error, StackTrace? stackTrace) => Center(
                      child: Text("Error : $error"),
                    ),
                loading: () => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextEntry(
                keyboardType: TextInputType.text,
                label: VoteTextConstants.name,
                suffix: '',
                isInt: false,
                controller: name,
              ),
            ),
            const SizedBox(height: 50),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 15),
                  ...ListType.values.map(
                    (e) => SectionChip(
                      label: capitalize(e.toString().split('.').last),
                      selected: listType.value == e,
                      onTap: () async {
                        listType.value = e;
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextEntry(
                keyboardType: TextInputType.text,
                controller: description,
                isInt: false,
                label: VoteTextConstants.description,
                suffix: '',
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: users.value.when(data: (u) {
                return Column(children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      print("value: $value");
                      print("lastQuery: ${lastQuery.value}");
                      if (value.isNotEmpty) {
                        if (value != lastQuery.value) {
                          lastQuery.value = value;
                          tokenExpireWrapper(ref, () async {
                            final value = await usersNotifier
                                .filterUsers(queryController.text);
                            users.value = value;
                            displayUserSearch.value = true;
                          });
                          focus.value = true;
                        } else {
                          focus.value = false;
                        }
                      }
                    },
                    cursorColor: Colors.black,
                    controller: queryController,
                    autofocus: focus.value,
                    decoration: const InputDecoration(
                      labelText: VoteTextConstants.members,
                      floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (displayUserSearch.value)
                    ...u.map(
                      (e) => GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      e.getName(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: (member.value.id == e.id)
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                          ),
                          onTap: () {
                            members.value.add(Member.fromSimpleUser(e));
                            member.value = Member.empty();
                            queryController.text = e.getName();
                            focus.value = false;
                            displayUserSearch.value = false;
                          }),
                    )
                ]);
              }, error: (error, s) {
                return Text(error.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500));
              }, loading: () {
                return const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(VoteColorConstants.green1),
                );
              }),
            ),
            const SizedBox(height: 50),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate()) {
                      tokenExpireWrapper(ref, () async {
                        final value =
                            await pretendanceListNotifier.addPretendance(
                          Pretendance(
                            name: name.text,
                            id: '',
                            description: description.text,
                            listType: listType.value,
                            members: members.value,
                            section: section.value,
                          ),
                        );
                        if (value) {
                          pageNotifier.setVotePage(VotePage.admin);
                          await sectionsNotifier.setTData(section.value,
                              await pretendanceListNotifier.copy());
                          displayVoteToastWithContext(
                              TypeMsg.msg, VoteTextConstants.addedPretendance);
                        } else {
                          displayVoteToastWithContext(
                              TypeMsg.error, VoteTextConstants.addingError);
                        }
                      });
                    } else {
                      displayVoteToast(context, TypeMsg.error,
                          VoteTextConstants.incorrectOrMissingFields);
                    }
                  },
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
                ))
          ]),
        ));
  }
}
