import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/booking/providers/is_admin_provider.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:myecl/tools/ui/layouts/column_refresher.dart';
import 'package:myecl/greenHouse/router.dart';
import 'package:myecl/greenHouse/providers/is_greenhouse_admin_provider.dart';
import 'package:myecl/greenhouse/ui/pages/main_page/main_page.dart';
import 'package:myecl/greenhouse/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class GreenHouseMainPage extends HookConsumerWidget {
  const GreenHouseMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGreenHouseAdmin = ref.watch(isGreenHouseAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);
    double width = 300;
    double height = 300;
    double imageHeight = 175;
    double maxHeight = MediaQuery.of(context).size.height - 344;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopBar(
            title: 'GreenHouse',
            root: GreenHouseRouter.root,
          ),
          Expanded(
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (isAdmin)
                        AdminButton(
                          onTap: () {
                            QR.to(
                                GreenHouseRouter.root + GreenHouseRouter.admin);
                          },
                        ),
                      if (isGreenHouseAdmin)
                        AdminButton(
                          onTap: () {
                            QR.to(GreenHouseRouter.root +
                                GreenHouseRouter.addEditMember);
                          },
                          text: GreenHouseTextConstants.management,
                        ),
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
                          GreenHouseTextConstants.news,
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  height: maxHeight,
                  width: width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.greenAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  height: maxHeight,
                  width: width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.greenAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  height: maxHeight,
                  width: width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.greenAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  height: maxHeight,
                  width: width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.greenAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
