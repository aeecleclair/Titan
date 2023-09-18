import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/providers/cinema_topic_provider.dart';
import 'package:myecl/cinema/providers/is_cinema_admin.dart';
import 'package:myecl/cinema/providers/main_page_index_provider.dart';
import 'package:myecl/cinema/providers/scroll_provider.dart';
import 'package:myecl/cinema/providers/session_list_page_provider.dart';
import 'package:myecl/cinema/providers/session_list_provider.dart';
import 'package:myecl/cinema/providers/session_provider.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/cinema/ui/cinema.dart';
import 'package:myecl/cinema/ui/pages/main_page/session_card.dart';
import 'package:myecl/drawer/providers/is_web_format_provider.dart';
import 'package:myecl/tools/ui/admin_button.dart';
import 'package:myecl/tools/ui/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CinemaMainPage extends HookConsumerWidget {
  const CinemaMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionList = ref.watch(sessionListProvider);
    final sessionListNotifier = ref.read(sessionListProvider.notifier);
    final sessionNotifier = ref.watch(sessionProvider.notifier);
    final initialPageNotifier = ref.watch(mainPageIndexProvider.notifier);
    final initialPage = ref.watch(mainPageIndexProvider);
    int currentPage = initialPage;
    final pageController =
        ref.watch(sessionListPageControllerProvider(initialPage));
    final scrollNotifier = ref.watch(scrollProvider.notifier);
    final isAdmin = ref.watch(isCinemaAdminProvider);
    final isWebFormat = ref.watch(isWebFormatProvider);
    pageController.addListener(() {
      scrollNotifier.setScroll(pageController.page!);
      currentPage = pageController.page!.round();
    });

    return CinemaTemplate(
      child: Refresher(
          onRefresh: () async {
            await sessionListNotifier.loadSessions();
            ref.watch(mainPageIndexProvider.notifier).reset();
            ref.read(cinemaTopicsProvider.notifier).getTopics();
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 85,
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
                                color: Color.fromARGB(255, 149, 149, 149))),
                        if (isAdmin)
                          AdminButton(
                            onTap: () {
                              QR.to(CinemaRouter.root + CinemaRouter.admin);
                              initialPageNotifier.setMainPageIndex(currentPage);
                            },
                          )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                sessionList.when(data: (data) {
                  data.sort((a, b) => a.start.compareTo(b.start));
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
                  return Expanded(
                    child: isWebFormat
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: pageController,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return SessionCard(
                                session: data[index],
                                index: index,
                                onTap: () {},
                              );
                            })
                        : PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: pageController,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return SessionCard(
                                session: data[index],
                                index: index,
                                onTap: () {
                                  sessionNotifier.setSession(data[index]);
                                  QR.to(
                                      CinemaRouter.root + CinemaRouter.detail);
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
            ),
          )),
    );
  }
}
