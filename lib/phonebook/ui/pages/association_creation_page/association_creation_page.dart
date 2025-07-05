import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/phonebook/ui/components/groupement_bar.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AssociationCreationPage extends HookConsumerWidget {
  final scrollKey = GlobalKey();
  AssociationCreationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associations = ref.watch(associationListProvider);
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationGroupement = ref.watch(associationGroupementProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return PhonebookTemplate(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.phonebookAddAssociation,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.gradient1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              KindsBar(key: scrollKey),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Container(margin: const EdgeInsets.symmetric(vertical: 10)),
                    TextEntry(
                      controller: name,
                      label: AppLocalizations.of(context)!.adminName,
                      canBeEmpty: false,
                    ),
                    const SizedBox(height: 30),
                    TextEntry(
                      controller: description,
                      label: AppLocalizations.of(context)!.adminDescription,
                      canBeEmpty: true,
                    ),
                    const SizedBox(height: 50),
                    WaitingButton(
                      builder: (child) => AddEditButtonLayout(
                        colors: const [
                          ColorConstants.gradient1,
                          ColorConstants.gradient2,
                        ],
                        child: child,
                      ),
                      onTap: () async {
                        if (!key.currentState!.validate()) {
                          displayToastWithContext(
                            TypeMsg.error,
                            AppLocalizations.of(
                              context,
                            )!.phonebookEmptyFieldError,
                          );
                          return;
                        }
                        if (associationGroupement == '') {
                          displayToastWithContext(
                            TypeMsg.error,
                            AppLocalizations.of(
                              context,
                            )!.phonebookEmptyKindError,
                          );
                          return;
                        }
                        await tokenExpireWrapper(ref, () async {
                          final addedMsg = AppLocalizations.of(
                            context,
                          )!.phonebookAddedAssociation;
                          final adminAddingErrorMsg = AppLocalizations.of(
                            context,
                          )!.adminAddingError;
                          final value = await associationListNotifier
                              .createAssociation(
                                Association.empty().copyWith(
                                  name: name.text,
                                  description: description.text,
                                  groupementId: associationGroupement.id,
                                  mandateYear: DateTime.now().year,
                                ),
                              );
                          if (value) {
                            displayToastWithContext(TypeMsg.msg, addedMsg);
                            associations.when(
                              data: (d) {
                                associationNotifier.setAssociation(d.last);
                                QR.to(
                                  PhonebookRouter.root +
                                      PhonebookRouter.admin +
                                      PhonebookRouter.editAssociation,
                                );
                              },
                              error: (e, s) => displayToastWithContext(
                                TypeMsg.error,
                                AppLocalizations.of(
                                  context,
                                )!.phonebookErrorAssociationLoading,
                              ),
                              loading: () {},
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              adminAddingErrorMsg,
                            );
                          }
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context)!.adminAdd,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
