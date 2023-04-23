import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_kinds_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/pages/association_creation_page/kind_chip.dart';
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


    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Form(
              key: key,
              child: Column(children: [
                const Center(
                  child: Text(AdminTextConstants.addAssociation,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1)),
                ),
                const SizedBox(
                  height: 30,
                ),
                associationKinds.when(
                      data: (value) {
                        return SingleChildScrollView(
                          child: Row(
                            children: [
                            const Spacer(),
                              ...value.kinds.map(
                              (e) => KindChip(
                                label: e,
                                selected: e == kind.value,
                                onTap: () async {
                                  kind.value = e;
                                },
                              )).toList(),
                              const Spacer(),
                            ]
                          )
                        );
                      },
                      error: (error, stack) {
                        return const Text(PhonebookTextConstants.errorKindsLoading);
                      },
                      loading: () {
                        return const CircularProgressIndicator();
                      },
                  ),
                Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 3),
                          child: const Text(
                            AdminTextConstants.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 158, 158, 158),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: name,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                isDense: true,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorConstants.gradient1))),
                            validator: (value) {
                              if (value == null) {
                                return AdminTextConstants.emptyFieldError;
                              } else if (value.isEmpty) {
                                return AdminTextConstants.emptyFieldError;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 3),
                          child: const Text(
                            AdminTextConstants.description,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 158, 158, 158),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: TextFormField(
                            controller: description,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                isDense: true,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorConstants.gradient1))),
                            validator: (value) {
                              if (value == null) {
                                return AdminTextConstants.emptyFieldError;
                              } else if (value.isEmpty) {
                                return AdminTextConstants.emptyFieldError;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ),
                
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
                      displayToastWithContext(TypeMsg.error, PhonebookTextConstants.emptyFieldError);
                      return;
                    }
                    if (kind.value == '') {
                      displayToastWithContext(TypeMsg.error, PhonebookTextConstants.emptyKindError);
                      return;
                    }
                    await tokenExpireWrapper(ref, () async {
                      final value = await associationListNotifier.createAssociation(
                          Association.empty().copyWith(
                              name: name.text,
                              description: description.text,
                              kind: kind.value));
                      if (value) {
                        displayToastWithContext(
                            TypeMsg.msg, PhonebookTextConstants.addedAssociation);
                        associations.when(data: (d) {
                          associationNotifier.setAssociation(d.last);
                          pageNotifier.setPhonebookPage(PhonebookPage.associationEditor);
                          },
                        error: (e, s) => displayToastWithContext(
                            TypeMsg.error, PhonebookTextConstants.errorAssociationLoading),
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
                )
              ]),
            )));
  }
}
