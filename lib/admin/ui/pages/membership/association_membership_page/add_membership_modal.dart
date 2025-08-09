import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class AddMembershipModal extends HookWidget {
  final List<SimpleGroup> groups;
  final void Function(SimpleGroup group, String name) onSubmit;
  final WidgetRef ref;

  const AddMembershipModal({
    super.key,
    required this.groups,
    required this.onSubmit,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final chosenGroup = useState<SimpleGroup?>(null);

    final localizeWithContext = AppLocalizations.of(context)!;

    return BottomModalTemplate(
      title: localizeWithContext.adminAssociationMembershipsManagement,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextEntry(
                label: localizeWithContext.adminName,
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: chosenGroup.value == null
                  ? ListItem(
                      title: localizeWithContext.adminChooseGroupManager,
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
                            child: Column(
                              children: [
                                ...groups.map(
                                  (e) => ListItem(
                                    title: e.name,
                                    onTap: () {
                                      chosenGroup.value = e;
                                      Navigator.of(ctx).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Text(chosenGroup.value!.name),
            ),
            const SizedBox(height: 10),
            Button(
              text: localizeWithContext.adminAdd,
              onPressed: () {
                if (chosenGroup.value != null) {
                  onSubmit(chosenGroup.value!, nameController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
