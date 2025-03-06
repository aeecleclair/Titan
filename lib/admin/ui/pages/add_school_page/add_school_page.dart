import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/school_list_provider.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/components/admin_button.dart';
import 'package:myecl/admin/ui/components/text_editing.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddSchoolPage extends HookConsumerWidget {
  const AddSchoolPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final emailRegex = useTextEditingController();
    final schoolListNotifier = ref.watch(allSchoolListProvider.notifier);
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
            child: Column(
              children: [
                const AlignLeftText(AdminTextConstants.addSchool),
                const SizedBox(height: 30),
                TextEditing(controller: name, label: AdminTextConstants.name),
                TextEditing(
                  controller: emailRegex,
                  label: AdminTextConstants.emailRegex,
                ),
                WaitingButton(
                  onTap: () async {
                    final value = await schoolListNotifier.createSchool(
                      CoreSchoolBase(
                        name: name.text,
                        emailRegex: emailRegex.text,
                      ),
                    );
                    if (value) {
                      QR.back();
                      displayToastWithContext(
                        TypeMsg.msg,
                        AdminTextConstants.addedSchool,
                      );
                    } else {
                      displayToastWithContext(
                        TypeMsg.error,
                        AdminTextConstants.addingError,
                      );
                    }
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
