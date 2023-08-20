import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/all_groups_list_provider.dart';
import 'package:myecl/admin/providers/all_module_visibilities_list_provider.dart';
import 'package:myecl/admin/ui/admin.dart';
import 'package:myecl/admin/providers/module_visibilities_list_provider.dart';

class EditModulesVisibilityPage extends HookConsumerWidget {
  const EditModulesVisibilityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modulesNotifier = ref.watch(moduleVisibilitiesListProvider.notifier);

    final modules = ref.watch(allModuleVisibilitiesList);
    final groups = ref.watch(allGroupList);

    final isOpen = useState<List<bool>>([]);

    return AdminTemplate(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: modules.isEmpty || groups.isEmpty
                ? const Text('Pas de module ou de groupe')
                : ExpansionPanelList(
                    expansionCallback: (i, isExpanded) {
                      isOpen.value[i] = !isOpen.value[i];
                      isOpen.value = List.from(isOpen
                          .value); // we create a copy so that the value update to a new list an rebuild the page
                    },
                    children: modules
                        .asMap()
                        .map((i, moduleVisibilities) {
                          if (isOpen.value.isEmpty) {
                            isOpen.value = groups.map((e) => false).toList();
                          }
                          return MapEntry(
                            i,
                            ExpansionPanel(
                              canTapOnHeader: true,
                              isExpanded: isOpen.value[i],
                              headerBuilder: (context, isExpanded) => Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  moduleVisibilities.root,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              body: Column(
                                  children: groups
                                      .map(
                                        (group) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Row(children: [
                                            Text(
                                              group.name,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Spacer(),
                                            moduleVisibilities.allowedGroupIds
                                                    .contains(group.id)
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      await modulesNotifier
                                                          .deleteGroupAccessForModule(
                                                              moduleVisibilities
                                                                  .root,
                                                              group.id);
                                                      await modulesNotifier
                                                          .loadModuleVisibilities();
                                                    },
                                                    child: const HeroIcon(
                                                      HeroIcons.eye,
                                                      size: 40,
                                                    ))
                                                : GestureDetector(
                                                    onTap: () async {
                                                      await modulesNotifier
                                                          .addGroupToModule(
                                                              moduleVisibilities
                                                                  .root,
                                                              group.id);
                                                      await modulesNotifier
                                                          .loadModuleVisibilities();
                                                    },
                                                    child: const HeroIcon(
                                                      HeroIcons.eyeSlash,
                                                      size: 40,
                                                    ))
                                          ]),
                                        ),
                                      )
                                      .toList()),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  )),
      ),
    );
  }
}
