import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/providers/cinema_page_provider.dart';
import 'package:myecl/cinema/providers/is_cinema_admin.dart';
import 'package:myecl/cinema/providers/main_page_index_provider.dart';
import 'package:myecl/cinema/providers/scroll_provider.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/cinema/providers/session_provider.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/cinema/ui/pages/main_page/session_card.dart';
import 'package:myecl/tools/refresher.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(cinemaPageProvider.notifier);
    final sessionList = ref.watch(sessionListProvider);
    final sessionListNotifier = ref.watch(sessionListProvider.notifier);
    final sessionNotifier = ref.watch(sessionProvider.notifier);
    final initialPageNotifier = ref.watch(mainPageIndexProvider.notifier);
    final initialPage = ref.watch(mainPageIndexProvider);
    int currentPage = initialPage;
    final pageController =
        usePageController(viewportFraction: 0.8, initialPage: initialPage);
    final scrollNotifier = ref.watch(scrollProvider.notifier);
    final isAdmin = ref.watch(isCinemaAdmin);
    pageController.addListener(() {
      scrollNotifier.setScroll(pageController.page!);
      currentPage = pageController.page!.round();
    });

    return Refresher(
        onRefresh: () async {
          await sessionListNotifier.loadSessions();
        },
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(CinemaTextConstants.incomingSession,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 205, 205, 205))),
                    if (isAdmin)
                      GestureDetector(
                        onTap: () {
                          pageNotifier.setCinemaPage(CinemaPage.admin);
                          initialPageNotifier.setMainPageIndex(currentPage);
                        },
                        child: Container(
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
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            sessionList.when(data: (data) {
              if (data.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(CinemaTextConstants.noSession,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height - 252,
                child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return SessionCard(
                        session: data[index],
                        index: index,
                        onTap: () {
                          sessionNotifier.setSession(data[index]);
                          pageNotifier
                              .setCinemaPage(CinemaPage.detailFromMainPage);
                          initialPageNotifier.setMainPageIndex(index);
                        },
                      );
                    }),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, error: (error, stackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            }),
          ],
        ));
  }
}
