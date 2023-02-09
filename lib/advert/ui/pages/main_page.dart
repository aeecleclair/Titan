import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/providers/advert_page_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/cinema/providers/main_page_index_provider.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(advertPageProvider.notifier);
    final initialPageNotifier = ref.watch(mainPageIndexProvider.notifier);
    final initialPage = ref.watch(mainPageIndexProvider);
    int currentPage = initialPage;
    return Refresher(
      onRefresh: () async {
        //await sessionListNotifier.loadSessions();
      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          if (true)
                    GestureDetector(
                      onTap: () {
                        pageNotifier.setAdvertPage(AdvertPage.admin);
                        initialPageNotifier.setMainPageIndex(currentPage);
                      },
                      child: Container(
                        width: 120,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5))
                            ]),
                        child: Row(
                          children: const [
                            HeroIcon(HeroIcons.userGroup,
                                color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text("Admin",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5))
                            ]),
                    child: ToggleSwitch(
                      customWidths: [160,130],
                      initialLabelIndex: 0,
                      totalSwitches: 2,
                      labels: const [
                        AdvertTextConstants.strassAdvert,
                        AdvertTextConstants.assoAdvert
                      ],
                      customTextStyles: const [TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                    )],
                      cornerRadius: 30,
                      radiusStyle: true,
                      activeFgColor: Colors.white,
                      activeBgColors: [[Colors.blue],[Colors.orange]],
                      inactiveFgColor: Colors.black,
                      inactiveBgColor: Color.fromARGB(255, 149, 149, 149),
                      onToggle: (index) {
                        print('switched to: $index');
                      },
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
