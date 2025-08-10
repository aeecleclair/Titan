import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/super_admin/providers/school_list_provider.dart';
import 'package:titan/super_admin/providers/school_provider.dart';
import 'package:titan/super_admin/router.dart';
import 'package:titan/super_admin/ui/admin.dart';
import 'package:titan/super_admin/ui/components/item_card_ui.dart';
import 'package:titan/super_admin/ui/pages/schools/school_page/school_ui.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class SchoolsPage extends HookConsumerWidget {
  const SchoolsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schools = ref.watch(allSchoolListProvider);
    final schoolsNotifier = ref.watch(allSchoolListProvider.notifier);
    final schoolNotifier = ref.watch(schoolProvider.notifier);
    ref.watch(userList);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SuperAdminTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await schoolsNotifier.loadSchools();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.adminSchools,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.gradient1,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              AsyncChild(
                value: schools,
                builder: (context, g) {
                  g.sort(
                    (a, b) =>
                        a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                  );
                  return Column(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              QR.to(
                                SuperAdminRouter.root +
                                    SuperAdminRouter.schools +
                                    SuperAdminRouter.addSchool,
                              );
                            },
                            child: ItemCardUi(
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
                          ...g.map(
                            (school) => SchoolUi(
                              school: school,
                              onEdit: () {
                                schoolNotifier.setSchool(school);
                                QR.to(
                                  SuperAdminRouter.root +
                                      SuperAdminRouter.schools +
                                      SuperAdminRouter.editSchool,
                                );
                              },
                              onDelete: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      title: AppLocalizations.of(
                                        context,
                                      )!.adminDeleting,
                                      descriptions: AppLocalizations.of(
                                        context,
                                      )!.adminDeleteSchool,
                                      onYes: () async {
                                        final deletedMsg = AppLocalizations.of(
                                          context,
                                        )!.adminDeletedSchool;
                                        final errorMsg = AppLocalizations.of(
                                          context,
                                        )!.adminDeletingError;
                                        tokenExpireWrapper(ref, () async {
                                          final value = await schoolsNotifier
                                              .deleteSchool(school);
                                          if (value) {
                                            displayToastWithContext(
                                              TypeMsg.msg,
                                              deletedMsg,
                                            );
                                          } else {
                                            displayToastWithContext(
                                              TypeMsg.error,
                                              errorMsg,
                                            );
                                          }
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                },
                loaderColor: ColorConstants.gradient1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
