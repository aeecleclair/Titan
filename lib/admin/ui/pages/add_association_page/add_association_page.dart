import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/components/admin_button.dart';
import 'package:myecl/admin/ui/components/text_editing.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddAssociationPage extends HookConsumerWidget {
  const AddAssociationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final description = useTextEditingController();
    final groupListNotifier = ref.watch(allGroupListProvider.notifier);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AdminTemplate(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Form(
                key: key,
                child: Column(children: [
                  const AlignLeftText(AdminTextConstants.addAssociation),
                  const SizedBox(height: 30),
                  TextEditing(controller: name, label: AdminTextConstants.name),
                  TextEditing(
                      controller: description,
                      label: AdminTextConstants.description),
                  WaitingButton(
                    onTap: () async {
                      await tokenExpireWrapper(ref, () async {
                        final value = await groupListNotifier.createGroup(
                            SimpleGroup(
                                name: name.text,
                                description: description.text,
                                id: ''));
                        if (value) {
                          QR.back();
                          displayToastWithContext(
                              TypeMsg.msg, AdminTextConstants.addedAssociation);
                        } else {
                          displayToastWithContext(
                              TypeMsg.error, AdminTextConstants.addingError);
                        }
                      });
                    },
                    builder: (child) => AdminButton(child: child),
                    child: const Text(
                      AdminTextConstants.add,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
              ))),
    );
  }
}
