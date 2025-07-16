import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/class/school.dart';
import 'package:titan/super_admin/providers/school_list_provider.dart';
import 'package:titan/super_admin/providers/school_provider.dart';
import 'package:titan/super_admin/tools/function.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/super_admin/ui/components/admin_button.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class EditSchoolPage extends HookConsumerWidget {
  const EditSchoolPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final school = ref.watch(schoolProvider);
    final schoolNotifier = ref.watch(schoolProvider.notifier);
    final schoolListNotifier = ref.watch(allSchoolListProvider.notifier);
    final key = GlobalKey<FormState>();
    final name = useTextEditingController();
    final emailRegex = useTextEditingController();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    name.text = getSchoolNameFromId(school.id, school.name, context);
    emailRegex.text = school.emailRegex;

    return SuperAdminTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            AlignLeftText(
              AppLocalizations.of(context)!.adminEdit,
              fontSize: 20,
              color: ColorConstants.gradient1,
            ),
            const SizedBox(height: 20),
            Form(
              key: key,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: TextEntry(
                      controller: name,
                      color: ColorConstants.gradient1,
                      label: AppLocalizations.of(context)!.adminName,
                      suffixIcon: const HeroIcon(HeroIcons.pencil),
                      enabledColor: Colors.transparent,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: TextEntry(
                      controller: emailRegex,
                      color: ColorConstants.gradient1,
                      label: AppLocalizations.of(context)!.adminEmailRegex,
                      suffixIcon: const HeroIcon(HeroIcons.pencil),
                      enabledColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  WaitingButton(
                    onTap: () async {
                      if (!key.currentState!.validate()) {
                        return;
                      }
                      final updatedGroupMsg = AppLocalizations.of(
                        context,
                      )!.adminUpdatedGroup;
                      final updatingErrorMsg = AppLocalizations.of(
                        context,
                      )!.adminUpdatingError;
                      await tokenExpireWrapper(ref, () async {
                        School newSchool = school.copyWith(
                          name: name.text,
                          emailRegex: emailRegex.text,
                        );
                        schoolNotifier.setSchool(newSchool);
                        final value = await schoolListNotifier.updateSchool(
                          newSchool,
                        );
                        if (value) {
                          QR.back();
                          displayToastWithContext(TypeMsg.msg, updatedGroupMsg);
                        } else {
                          displayToastWithContext(
                            TypeMsg.msg,
                            updatingErrorMsg,
                          );
                        }
                      });
                    },
                    builder: (child) => SuperAdminButton(child: child),
                    child: Text(
                      AppLocalizations.of(context)!.adminEdit,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
