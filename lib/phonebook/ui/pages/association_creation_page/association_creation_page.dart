import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/association_provider.dart';
import 'package:myecl/phonebook/router.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/phonebook/ui/components/kinds_bar.dart';
import 'package:myecl/phonebook/ui/phonebook.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

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
    final associationNotifier = ref.watch(asyncAssociationProvider.notifier);
    final kind = useState('');

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
                KindsBar(key: scrollKey),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                      TextEntry(
                          controller: name,
                          label: AdminTextConstants.name,
                          canBeEmpty: false),
                      const SizedBox(height: 30),
                      TextEntry(
                          controller: description,
                          label: AdminTextConstants.description,
                          canBeEmpty: true),
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
                            final value =
                                await associationListNotifier.createAssociation(
                              Association.empty().copyWith(
                                  name: name.text,
                                  description: description.text,
                                  kind: kind.value,
                                  mandateYear: DateTime.now().year),
                            );
                            if (value) {
                              displayToastWithContext(TypeMsg.msg,
                                  PhonebookTextConstants.addedAssociation);
                              associations.when(
                                  data: (d) {
                                    associationNotifier.setAssociation(d.last);
                                    QR.to(PhonebookRouter.root +
                                        PhonebookRouter.admin +
                                        PhonebookRouter.editAssociation);
                                  },
                                  error: (e, s) => displayToastWithContext(
                                      TypeMsg.error,
                                      PhonebookTextConstants
                                          .errorAssociationLoading),
                                  loading: () {});
                            } else {
                              displayToastWithContext(TypeMsg.error,
                                  AdminTextConstants.addingError);
                            }
                          });
                        },
                        child: const Text(
                          AdminTextConstants.add,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            )));
  }
}
