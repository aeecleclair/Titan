import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/ui/pages/admin_page/asso_ui.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_id_provider.dart';

class AssociationBar extends HookConsumerWidget {
  const AssociationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationsNotifier = ref.watch(allAssociationListProvider.notifier);
    final associations = ref.watch(allAssociationListProvider);
    final associationIdNotifier = ref.watch(associationIdProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }


    return Refresher(
        onRefresh: () async {
            await associationsNotifier.loadAssociations();
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: associations.when(data: (a) {
            return Column(children: [
                Column(
                children: [
                    GestureDetector(
                    onTap: () {
                        pageNotifier.setPhonebookPage(PhonebookPage.addEditAssociation);
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5,
                                spreadRadius: 2)
                            ]),
                        child: Row(
                        children: [
                            const Spacer(),
                            HeroIcon(
                            HeroIcons.plus,
                            color: Colors.grey.shade700,
                            size: 40,
                            ),
                            const Spacer(),
                        ],
                        ),
                    ),
                    ),
                    ...a
                        .map((association) => AssoUi(
                            association: association,
                            onEdit: () {
                                associationIdNotifier.setId(association.id);
                                pageNotifier.setPhonebookPage(PhonebookPage.addEditAssociation);
                            },
                            onDelete: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                    return CustomDialogBox(
                                        title: PhonebookTextConstants.deleting,
                                        descriptions:
                                            PhonebookTextConstants.deleteAssociation,
                                        onYes: () async {
                                        tokenExpireWrapper(ref, () async {
                                            final value = await associationsNotifier
                                                .deleteAssociation(association);
                                            if (value) {
                                            displayToastWithContext(
                                                TypeMsg.msg,
                                                PhonebookTextConstants
                                                    .deletedAssociation);
                                            } else {
                                            displayToastWithContext(TypeMsg.error,
                                                PhonebookTextConstants.deletingError);
                                            }
                                        });
                                        },
                                    );
                                    });
                            },
                            ))
                        .toList(),
                    const SizedBox(
                    height: 20,
                    )
                ],
                ),
            ]);
            }, error: (e, s) {
            return Text(e.toString());
            }, loading: () {
            return const Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorConstants.gradient1),
            ));
            }),
        ),
        );
    }
}