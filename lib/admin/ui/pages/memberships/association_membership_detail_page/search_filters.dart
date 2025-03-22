import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/association_membership_members_list_provider.dart';
import 'package:myecl/admin/providers/association_membership_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/date_entry.dart';

class SearchFilters extends HookConsumerWidget {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationMembershipMemberListNotifier =
        ref.watch(associationMembershipMembersProvider.notifier);
    final associationMembership = ref.watch(associationMembershipProvider);
    final startMinimal = useTextEditingController(
      text: "",
    );
    final startMaximal = useTextEditingController(
      text: processDate(DateTime.now()),
    );
    final endMinimal = useTextEditingController(
      text: processDate(DateTime.now()),
    );
    final endMaximal = useTextEditingController(
      text: "",
    );

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: [
                  Text(
                    AdminTextConstants.startDate,
                    style: const TextStyle(fontSize: 18),
                  ),
                  DateEntry(
                    label: AdminTextConstants.minimum,
                    controller: startMinimal,
                    onTap: () => getOnlyDayDate(
                      context,
                      startMinimal,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(DateTime.now().year + 7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DateEntry(
                    label: AdminTextConstants.maximum,
                    controller: startMaximal,
                    onTap: () => getOnlyDayDate(
                      context,
                      startMaximal,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(DateTime.now().year + 7),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                children: [
                  Text(
                    AdminTextConstants.endDate,
                    style: const TextStyle(fontSize: 18),
                  ),
                  DateEntry(
                    label: AdminTextConstants.minimum,
                    controller: endMinimal,
                    onTap: () => getOnlyDayDate(
                      context,
                      endMinimal,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(DateTime.now().year + 7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DateEntry(
                    label: AdminTextConstants.maximum,
                    controller: endMaximal,
                    onTap: () => getOnlyDayDate(
                      context,
                      endMaximal,
                      firstDate: DateTime(2019),
                      lastDate: DateTime(DateTime.now().year + 7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Spacer(
              flex: 2,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: WaitingButton(
                onTap: () async {
                  await tokenExpireWrapper(
                    ref,
                    () async {
                      await associationMembershipMemberListNotifier
                          .loadAssociationMembershipMembers(
                        associationMembership.id,
                        minimalStartDate: startMinimal.text.isNotEmpty
                            ? DateTime.parse(processDateBack(startMinimal.text))
                            : null,
                        minimalEndDate: endMinimal.text.isNotEmpty
                            ? DateTime.parse(processDateBack(endMinimal.text))
                            : null,
                        maximalStartDate: startMaximal.text.isNotEmpty
                            ? DateTime.parse(processDateBack(startMaximal.text))
                            : null,
                        maximalEndDate: endMaximal.text.isNotEmpty
                            ? DateTime.parse(processDateBack(endMaximal.text))
                            : null,
                      );
                    },
                  );
                },
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    ColorConstants.gradient1,
                    ColorConstants.gradient2,
                  ],
                  child: child,
                ),
                child: AutoSizeText(
                  AdminTextConstants.validateFilters,
                  maxFontSize: 18,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: WaitingButton(
                onTap: () async {
                  startMaximal.clear();
                  startMinimal.clear();
                  endMaximal.clear();
                  endMinimal.clear();
                  await tokenExpireWrapper(
                    ref,
                    () async {
                      await associationMembershipMemberListNotifier
                          .loadAssociationMembershipMembers(
                        associationMembership.id,
                      );
                    },
                  );
                },
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    ColorConstants.gradient1,
                    ColorConstants.gradient2,
                  ],
                  child: child,
                ),
                child: AutoSizeText(
                  AdminTextConstants.clearFilters,
                  maxFontSize: 18,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
