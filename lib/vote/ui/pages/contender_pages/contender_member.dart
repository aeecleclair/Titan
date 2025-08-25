import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:titan/vote/class/members.dart';
import 'package:titan/vote/providers/contender_members.dart';
import 'package:titan/vote/providers/display_results.dart';
import 'package:titan/vote/ui/pages/contender_pages/search_result.dart';

class ContenderMember extends HookConsumerWidget {
  const ContenderMember({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addMemberKey = GlobalKey<FormState>();
    final usersNotifier = ref.read(userList.notifier);
    final queryController = useTextEditingController();
    final role = useTextEditingController();
    final membersNotifier = ref.read(contenderMembersProvider.notifier);
    final member = useState(SimpleUser.empty());

    void displayVoteToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final showNotifier = ref.read(displayResult.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.voteMembers,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorConstants.tertiary,
            ),
          ),
          const Spacer(),
          CustomIconButton(
            icon: HeroIcon(HeroIcons.plus, color: ColorConstants.background),
            onPressed: () async {
              await showCustomBottomModal(
                context: context,
                ref: ref,
                modal: BottomModalTemplate(
                  title: AppLocalizations.of(context)!.voteAddMember,
                  child: Form(
                    key: addMemberKey,
                    child: Column(
                      children: [
                        Column(
                          children: <Widget>[
                            TextEntry(
                              label: AppLocalizations.of(context)!.voteMembers,
                              onChanged: (newQuery) {
                                showNotifier.setId(true);
                                tokenExpireWrapper(ref, () async {
                                  if (queryController.text.isNotEmpty) {
                                    await usersNotifier.filterUsers(
                                      queryController.text,
                                    );
                                  } else {
                                    usersNotifier.clear();
                                  }
                                });
                              },
                              color: Colors.black,
                              controller: queryController,
                            ),
                            const SizedBox(height: 10),
                            SearchResult(
                              borrower: member,
                              queryController: queryController,
                            ),
                            TextEntry(
                              label: AppLocalizations.of(context)!.voteRole,
                              controller: role,
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () async {
                                if (addMemberKey.currentState == null) {
                                  return;
                                }
                                if (member.value.id == '' || role.text == '') {
                                  return;
                                }
                                final alreadyAddedMemberMsg =
                                    AppLocalizations.of(
                                      context,
                                    )!.voteAlreadyAddedMember;
                                if (addMemberKey.currentState!.validate()) {
                                  final value = await membersNotifier.addMember(
                                    Member.fromSimpleUser(
                                      member.value,
                                      role.text,
                                    ),
                                  );
                                  if (value) {
                                    role.text = '';
                                    member.value = SimpleUser.empty();
                                    queryController.text = '';
                                    QR.back();
                                  } else {
                                    displayVoteToastWithContext(
                                      TypeMsg.error,
                                      alreadyAddedMemberMsg,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 12,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.5),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(3, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.voteAdd,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
