import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/navigation/providers/navbar_module_list.dart';
import 'package:titan/navigation/providers/navbar_visibility_provider.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/router.dart';
import 'package:titan/settings/providers/module_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';
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
    return Container(
      color: ColorConstants.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          TopBar(root: AppRouter.allModules),
          Expanded(
            child: ScrollToHideNavbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      CustomSearchBar(
                        onSearch: (String query) {},
                        onFilter: () {},
                      ),
                      SizedBox(height: 30),
                      ...modules.map(
                        (module) => ListItem(
                          title: module.getName(context),
                          subtitle: module.description,
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
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
