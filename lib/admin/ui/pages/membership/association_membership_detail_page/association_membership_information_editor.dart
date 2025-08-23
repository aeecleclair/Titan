import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/association_membership_list_provider.dart';
import 'package:titan/admin/providers/association_membership_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class AssociationMembershipInformationEditor extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationMembershipInformationEditor({super.key});

  @override
  Widget build(context, ref) {
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final associationMembership = ref.watch(associationMembershipProvider);
    final associationMembershipNotifier = ref.watch(
      associationMembershipProvider.notifier,
    );
    final name = useTextEditingController(text: associationMembership.name);
    final groups = ref.watch(allGroupList);
    final groupIdController = useTextEditingController(
      text: associationMembership.managerGroupId,
    );
    final associationMembershipListNotifier = ref.watch(
      allAssociationMembershipListProvider.notifier,
    );
    final key = GlobalKey<FormState>();
    final localizeWithContext = AppLocalizations.of(context)!;

    groups.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return Form(
      key: key,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: name,
                    cursorColor: ColorConstants.tertiary,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.adminName,
                      labelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const HeroIcon(HeroIcons.pencil),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorConstants.tertiary),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          context,
                        )!.adminEmptyFieldError;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.adminGroup,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListItem(
            title: groups
                .firstWhere((group) => group.id == groupIdController.text)
                .name,
            onTap: () async {
              FocusScope.of(context).unfocus();
              final ctx = context;
              await Future.delayed(Duration(milliseconds: 150));
              if (!ctx.mounted) return;

              await showCustomBottomModal(
                context: ctx,
                ref: ref,
                modal: BottomModalTemplate(
                  title: localizeWithContext.adminChooseGroupManager,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 280),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ...groups.map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.name,
                                      style: const TextStyle(fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      groupIdController.text = e.id;
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const HeroIcon(HeroIcons.plus),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          WaitingButton(
            builder: (child) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstants.tertiary,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorConstants.onTertiary),
              ),
              child: Center(child: child),
            ),
            onTap: () async {
              if (!key.currentState!.validate()) {
                return;
              }

              await tokenExpireWrapper(ref, () async {
                final updatedAssociationMembershipMsg = AppLocalizations.of(
                  context,
                )!.adminUpdatedAssociationMembership;
                final updatingAssociationMembershipErrorMsg =
                    AppLocalizations.of(context)!.adminUpdatingError;
                final value = await associationMembershipListNotifier
                    .updateAssociationMembership(
                      associationMembership.copyWith(name: name.text),
                    );
                if (value) {
                  associationMembershipNotifier.setAssociationMembership(
                    associationMembership.copyWith(
                      name: name.text,
                      managerGroupId: groupIdController.text,
                    ),
                  );
                  displayToastWithContext(
                    TypeMsg.msg,
                    updatedAssociationMembershipMsg,
                  );
                } else {
                  displayToastWithContext(
                    TypeMsg.msg,
                    updatingAssociationMembershipErrorMsg,
                  );
                }
              });
            },
            child: Text(
              AppLocalizations.of(context)!.adminEdit,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
