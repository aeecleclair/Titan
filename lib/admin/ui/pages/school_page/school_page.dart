import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/school_list_provider.dart';
import 'package:myecl/admin/providers/school_provider.dart';
import 'package:myecl/admin/router.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/ui/pages/school_page/school_ui.dart';
import 'package:myecl/admin/ui/pages/main_page/card_ui.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

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

    return AdminTemplate(
      child: Refresher(
        onRefresh: () async {
          await schoolsNotifier.loadSchools();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: AsyncChild(
            value: schools,
            builder: (context, g) {
              g.sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
              );
              return Column(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          QR.to(
                            AdminRouter.root +
                                AdminRouter.schools +
                                AdminRouter.addSchool,
                          );
                        },
                        child: CardUi(
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
                              AdminRouter.root +
                                  AdminRouter.schools +
                                  AdminRouter.editSchool,
                            );
                          },
                          onDelete: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialogBox(
                                  title: AdminTextConstants.deleting,
                                  descriptions:
                                      AdminTextConstants.deleteAssociation,
                                  onYes: () async {
                                    tokenExpireWrapper(ref, () async {
                                      final value = await schoolsNotifier
                                          .deleteSchool(school);
                                      if (value) {
                                        displayToastWithContext(
                                          TypeMsg.msg,
                                          AdminTextConstants.deletedAssociation,
                                        );
                                      } else {
                                        displayToastWithContext(
                                          TypeMsg.error,
                                          AdminTextConstants.deletingError,
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
        ),
      ),
    );
  }
}
