import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/association_creation_page/text_entry.dart';
import 'package:myecl/phonebook/ui/radio_chip.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AssociationCreationPage extends HookConsumerWidget {
  const AssociationCreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associations = ref.watch(associationListProvider);
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final associationKinds = ref.watch(associationKindsProvider);
    final kind = useState('');

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Form(
          key: key,
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(AdminTextConstants.addAssociation,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.gradient1)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            associationKinds.when(
              data: (value) {
                return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(children: [
                      const SizedBox(width: 15),
                      ...value.kinds
                          .map((e) => RadioChip(
                                label: e,
                                selected: e == kind.value,
                                onTap: () async {
                                  kind.value = e;
                                },
                              ))
                          .toList(),
                      const SizedBox(width: 15),
                    ]));
              },
              error: (error, stack) {
                return const Text(PhonebookTextConstants.errorKindsLoading);
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                  ),
                  AddAssociationTextEntry(
                      controller: name, title: AdminTextConstants.name),
                  AddAssociationTextEntry(
                      controller: description,
                      title: AdminTextConstants.description),
                  ShrinkButton(
                    waitChild: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            ColorConstants.gradient1,
                            ColorConstants.gradient2,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.gradient2.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (!key.currentState!.validate()) {
                        displayToastWithContext(TypeMsg.error,
                            PhonebookTextConstants.emptyFieldError);
                        return;
                      }
                      if (kind.value == '') {
                        displayToastWithContext(TypeMsg.error,
                            PhonebookTextConstants.emptyKindError);
                        return;
                      }
                      await tokenExpireWrapper(ref, () async {
                        final value = await associationListNotifier
                            .createAssociation(Association.empty().copyWith(
                                name: name.text,
                                description: description.text,
                                kind: kind.value));
                        if (value) {
                          displayToastWithContext(TypeMsg.msg,
                              PhonebookTextConstants.addedAssociation);
                          associations.when(
                              data: (d) {
                                associationNotifier.setAssociation(d.last);
                                pageNotifier.setPhonebookPage(
                                    PhonebookPage.associationEditor);
                              },
                              error: (e, s) => displayToastWithContext(
                                  TypeMsg.error,
                                  PhonebookTextConstants
                                      .errorAssociationLoading),
                              loading: () {});
                        } else {
                          displayToastWithContext(
                              TypeMsg.error, AdminTextConstants.addingError);
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            ColorConstants.gradient1,
                            ColorConstants.gradient2,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.gradient2.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        AdminTextConstants.add,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
