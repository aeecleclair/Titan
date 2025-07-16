import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/class/school.dart';
import 'package:titan/super_admin/providers/school_list_provider.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/super_admin/ui/components/admin_button.dart';
import 'package:titan/super_admin/ui/components/text_editing.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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

    return SuperAdminTemplate(
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
                AlignLeftText(AppLocalizations.of(context)!.adminAddSchool),
                const SizedBox(height: 30),
                TextEditing(
                  controller: name,
                  label: AppLocalizations.of(context)!.adminName,
                ),
                TextEditing(
                  controller: emailRegex,
                  label: AppLocalizations.of(context)!.adminEmailRegex,
                ),
                WaitingButton(
                  onTap: () async {
                    await tokenExpireWrapper(ref, () async {
                      final addedSchoolMsg = AppLocalizations.of(
                        context,
                      )!.adminAddedSchool;
                      final addingErrorMsg = AppLocalizations.of(
                        context,
                      )!.adminAddingError;
                      final value = await schoolListNotifier.createSchool(
                        School(
                          name: name.text,
                          emailRegex: emailRegex.text,
                          id: '',
                        ),
                      );
                      if (value) {
                        QR.back();
                        displayToastWithContext(TypeMsg.msg, addedSchoolMsg);
                      } else {
                        displayToastWithContext(TypeMsg.error, addingErrorMsg);
                      }
                    });
                  },
                  builder: (child) => SuperAdminButton(child: child),
                  child: Text(
                    AppLocalizations.of(context)!.adminAdd,
                    style: const TextStyle(
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
