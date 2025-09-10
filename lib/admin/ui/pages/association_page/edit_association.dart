import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/assocation_list_provider.dart';
import 'package:titan/admin/providers/association_logo_provider.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/settings/ui/pages/main_page/picture_button.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';

class EditAssociation extends HookConsumerWidget {
  final Association association;
  final SimpleGroup group;
  const EditAssociation({
    super.key,
    required this.association,
    required this.group,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final nameController = useTextEditingController(text: association.name);
    final groups = ref.watch(allGroupList);
    final chosenGroup = useState<SimpleGroup?>(group);
    final associationLogo = ref.watch(associationLogoProvider);
    final associationLogoNotifier = ref.watch(associationLogoProvider.notifier);

    MediaQuery.of(context).viewInsets.bottom;

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final localizeWithContext = AppLocalizations.of(context)!;
    final navigatorWithContext = Navigator.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (View.of(context).viewInsets.bottom == 0)
            AsyncChild(
              value: associationLogo,
              builder: (context, associationLogo) {
                return Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: Image(
                            image: associationLogo.image,
                          ).image,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () async {
                            final value = await associationLogoNotifier.setLogo(
                              ImageSource.gallery,
                              association.id,
                            );
                            if (value != null) {
                              if (value) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  localizeWithContext
                                      .adminUpdatedAssociationLogo,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext.adminTooHeavyLogo,
                                );
                              }
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                localizeWithContext
                                    .adminFailedToUpdateAssociationLogo,
                              );
                            }
                          },
                          child: const PictureButton(icon: HeroIcons.photo),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            final value = await associationLogoNotifier.setLogo(
                              ImageSource.camera,
                              association.id,
                            );
                            if (value != null) {
                              if (value) {
                                displayToastWithContext(
                                  TypeMsg.msg,
                                  localizeWithContext
                                      .adminUpdatedAssociationLogo,
                                );
                              } else {
                                displayToastWithContext(
                                  TypeMsg.error,
                                  localizeWithContext.adminTooHeavyLogo,
                                );
                              }
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                localizeWithContext
                                    .adminFailedToUpdateAssociationLogo,
                              );
                            }
                          },
                          child: const PictureButton(icon: HeroIcons.camera),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          SizedBox(height: View.of(context).viewInsets.bottom == 0 ? 30 : 10),
          TextEntry(
            label: localizeWithContext.adminAssociationName,
            controller: nameController,
          ),
          SizedBox(height: 20),
          ListItem(
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
                    constraints: BoxConstraints(maxHeight: 600),
                    child: SingleChildScrollView(
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
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Button(
            text: localizeWithContext.globalConfirm,
            disabled:
                !(nameController.value.text != association.name ||
                    chosenGroup.value!.id != association.groupId),
            onPressed: () async {
              await tokenExpireWrapper(ref, () async {
                final newAssociation = association.copyWith(
                  name: nameController.value.text,
                  groupId: chosenGroup.value!.id,
                );
                final value = await associationListNotifier.updateAssociation(
                  newAssociation,
                );
                if (value) {
                  displayToastWithContext(
                    TypeMsg.msg,
                    localizeWithContext.adminAssociationUpdated,
                  );
                  navigatorWithContext.pop();
                } else {
                  displayToastWithContext(
                    TypeMsg.error,
                    localizeWithContext.adminAssociationUpdateError,
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
