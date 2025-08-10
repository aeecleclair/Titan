// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';

class AssociationGroupementAddEditPage extends HookConsumerWidget {
  const AssociationGroupementAddEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupement = ref.watch(associationGroupementProvider);
    final associaitonGroupementListNotifier = ref.watch(
      associationGroupementListProvider.notifier,
    );
    final name = useTextEditingController(text: associationGroupement.name);
    void showSnackBarWithContext(String message) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    AppLocalizations localizeWithContext = AppLocalizations.of(context)!;

    return PhonebookTemplate(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                associationGroupement.id.isNotEmpty
                    ? localizeWithContext.phonebookEditAssociationGroupement
                    : localizeWithContext.phonebookAddAssociationGroupement,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.title,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextEntry(
              controller: name,
              label: localizeWithContext.phonebookGroupementName,
              canBeEmpty: false,
            ),
            const SizedBox(height: 50),
            Button(
              text: associationGroupement.id != ""
                  ? localizeWithContext.phonebookEdit
                  : localizeWithContext.phonebookAdd,
              onPressed: () async {
                if (name.text.isEmpty) {
                  showSnackBarWithContext(
                    localizeWithContext.phonebookEmptyFieldError,
                  );
                  return;
                }
                await tokenExpireWrapper(ref, () async {
                  if (associationGroupement.id != "") {
                    final value = await associaitonGroupementListNotifier
                        .updateAssociationGroupement(
                          AssociationGroupement(
                            id: associationGroupement.id,
                            name: name.text,
                          ),
                        );
                    if (value) {
                      showSnackBarWithContext(
                        localizeWithContext.phonebookAddedAssociation,
                      );
                      QR.back();
                    } else {
                      showSnackBarWithContext(
                        localizeWithContext.phonebookUpdatingError,
                      );
                    }
                    return;
                  }
                  final value = await associaitonGroupementListNotifier
                      .createAssociationGroupement(
                        AssociationGroupement(id: "", name: name.text),
                      );
                  if (value) {
                    showSnackBarWithContext(
                      localizeWithContext.phonebookAddedAssociation,
                    );
                    QR.back();
                  } else {
                    showSnackBarWithContext(
                      localizeWithContext.phonebookAddingError,
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
