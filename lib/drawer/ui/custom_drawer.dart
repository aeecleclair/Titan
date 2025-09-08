import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/providers/is_web_format_provider.dart';
import 'package:titan/drawer/tools/constants.dart';
import 'package:titan/drawer/ui/bottom_bar.dart';
import 'package:titan/drawer/ui/fake_page.dart';
import 'package:titan/drawer/ui/list_module.dart';
import 'package:titan/drawer/ui/drawer_top_bar.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWebFormat = ref.watch(isWebFormatProvider);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            DrawerColorConstants.lightBlue,
            DrawerColorConstants.darkBlue,
          ],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [DrawerTopBar(), BottomBar()],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        height: MediaQuery.of(context).size.height * 4.4 / 10,
                        child: const ListModule(),
                      ),
                    ),
                    isWebFormat
                        ? Container(
                            width: MediaQuery.of(context).size.width - 220,
                          )
                        : const FakePage(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
