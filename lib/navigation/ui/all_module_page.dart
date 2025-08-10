import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/navigation/providers/navbar_module_list.dart';
import 'package:titan/navigation/providers/navbar_visibility_provider.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/router.dart';
import 'package:titan/settings/providers/module_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/providers/prefered_module_root_list_provider.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class AllModulePage extends HookConsumerWidget {
  const AllModulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ref.watch(modulesProvider);
    final navbarListModuleNotifier = ref.watch(
      navbarListModuleProvider.notifier,
    );
    final navbarVisibilityNotifier = ref.read(
      navbarVisibilityProvider.notifier,
    );
    final scrollController = useScrollController();
    final preferedModuleRootList = ref.watch(preferedModuleListRootProvider);
    final preferedModuleRootListNotifier = ref.watch(
      preferedModuleListRootProvider.notifier,
    );
    return Container(
      color: ColorConstants.background,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(root: AppRouter.allModules),
            Expanded(
              child: ScrollToHideNavbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        ...modules.map(
                          (module) => Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (preferedModuleRootList.contains(
                                    module.root,
                                  )) {
                                    preferedModuleRootListNotifier
                                        .removePreferedModulesRoot(module.root);
                                  } else if (preferedModuleRootList.length <
                                      2) {
                                    preferedModuleRootListNotifier
                                        .addPreferedModulesRoot(module.root);
                                  }
                                },
                                child: HeroIcon(
                                  HeroIcons.bookmark,
                                  style:
                                      preferedModuleRootList.contains(
                                        module.root,
                                      )
                                      ? HeroIconStyle.solid
                                      : HeroIconStyle.outline,
                                  size: 20,
                                  color:
                                      preferedModuleRootList.contains(
                                        module.root,
                                      )
                                      ? ColorConstants.main
                                      : ColorConstants.secondary,
                                ),
                              ),
                              Expanded(
                                child: ListItem(
                                  title: module.getName(context),
                                  subtitle: module.getDescription(context),
                                  onTap: () {
                                    navbarListModuleNotifier.pushModule(module);
                                    final pathForwardingNotifier = ref.watch(
                                      pathForwardingProvider.notifier,
                                    );
                                    pathForwardingNotifier.forward(module.root);

                                    QR.to(module.root);
                                    navbarVisibilityNotifier.show();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
