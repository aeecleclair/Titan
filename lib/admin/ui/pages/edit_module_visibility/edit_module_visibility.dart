import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/all_account_types_list_provider.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/module_visibility_list_provider.dart';
import 'package:titan/admin/tools/constants.dart';
import 'package:titan/admin/ui/admin.dart';
import 'package:titan/admin/ui/pages/edit_module_visibility/modules_expansion_panel.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/loader.dart';

class EditModulesVisibilityPage extends HookConsumerWidget {
  const EditModulesVisibilityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modulesProvider = ref.watch(moduleVisibilityListProvider);
    final groups = ref.watch(allGroupList);
    final accountTypes = ref.watch(allAccountTypes);
    return AdminTemplate(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AdminTextConstants.modifyModuleVisibility,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    AsyncChild(
                      value: modulesProvider,
                      builder: (context, modules) =>
                          modules.isEmpty ||
                              groups.isEmpty ||
                              accountTypes.isEmpty
                          ? const Loader()
                          : ModulesExpansionPanel(
                              modules: modules,
                              accountTypes: accountTypes,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
