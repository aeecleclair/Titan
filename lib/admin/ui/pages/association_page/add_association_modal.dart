import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/list_item_template.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class AddAssociationModal extends HookWidget {
  final List<SimpleGroup> groups;
  final void Function(SimpleGroup group, String name) onSubmit;
  final WidgetRef ref;

  const AddAssociationModal({
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
      title: localizeWithContext.adminAddAssociation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextEntry(
                label: localizeWithContext.adminAssociationName,
                controller: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: chosenGroup.value == null
                  ? ListItem(
                      title: localizeWithContext
                          .adminChooseAssociationManagerGroup,
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        final ctx = context;
                        await Future.delayed(Duration(milliseconds: 150));
                        if (!ctx.mounted) return;

                        await showCustomBottomModal(
                          context: ctx,
                          ref: ref,
                          modal: BottomModalTemplate(
                            title: localizeWithContext.adminChooseGroup,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 600),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    ...groups.map(
                                      (e) => ListItemTemplate(
                                        title: e.name,
                                        trailing: const HeroIcon(
                                          HeroIcons.plus,
                                        ),
                                        onTap: () {
                                          chosenGroup.value = e;
                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListItem(
                      title: localizeWithContext.adminManagerGroup(
                        chosenGroup.value!.name,
                      ),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        final ctx = context;
                        await Future.delayed(Duration(milliseconds: 150));
                        if (!ctx.mounted) return;

                        await showCustomBottomModal(
                          context: ctx,
                          ref: ref,
                          modal: BottomModalTemplate(
                            title: localizeWithContext.adminChooseGroup,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 600),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...groups.map(
                                      (e) => ListItemTemplate(
                                        title: e.name,
                                        trailing: const HeroIcon(
                                          HeroIcons.plus,
                                        ),
                                        onTap: () {
                                          chosenGroup.value = e;
                                          Navigator.of(ctx).pop();
                                        },
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
