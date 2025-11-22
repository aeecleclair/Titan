import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/booking/providers/is_admin_provider.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:titan/tools/ui/layouts/column_refresher.dart';
import 'package:titan/shotgun/router.dart';
import 'package:titan/shotgun/providers/is_shotgun_admin_provider.dart';
import 'package:titan/shotgun/ui/pages/main_page/main_page.dart';
import 'package:titan/shotgun/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ShotgunMainPage extends HookConsumerWidget {
  const ShotgunMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isShotgunAdmin = ref.watch(isShotgunAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);
    double width = 300;
    double height = 300;
    double imageHeight = 175;
    double maxHeight = MediaQuery.of(context).size.height - 344;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopBar(title: 'Shotgun', root: ShotgunRouter.root),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (isAdmin)
                          AdminButton(
                            onTap: () {
                              QR.to(ShotgunRouter.root + ShotgunRouter.admin);
                            },
                          ),
                        // if (isShotgunAdmin)
                        //   AdminButton(
                        //     onTap: () {
                        //       QR.to(
                        //         ShotgunRouter.root +
                        //             ShotgunRouter.addEditMember,
                        //       );
                        //     },
                        //     text: ShotgunTextConstants.management,
                        //   ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            ShotgunTextConstants.news,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
