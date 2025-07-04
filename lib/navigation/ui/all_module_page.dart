import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/navigation/providers/navbar_module_list.dart';
import 'package:titan/navigation/ui/top_bar.dart';
import 'package:titan/settings/providers/module_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class AllModulePage extends ConsumerWidget {
  const AllModulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = ref.watch(modulesProvider);
    final navbarListModuleNotifier = ref.watch(
      navbarListModuleProvider.notifier,
    );
    return Column(
      children: [
        TopBar(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: ColorConstants.background,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CustomSearchBar(onSearch: (String query) {}, onFilter: () {}),
                  SizedBox(height: 30),
                  ...modules.map(
                    (module) => ListItem(
                      title: module.name,
                      subtitle: module.description,
                      onTap: () {
                        navbarListModuleNotifier.pushModule(module);
                        final pathForwardingNotifier = ref.watch(
                          pathForwardingProvider.notifier,
                        );
                        pathForwardingNotifier.forward(module.root);
                        QR.to(module.root);
                      },
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
