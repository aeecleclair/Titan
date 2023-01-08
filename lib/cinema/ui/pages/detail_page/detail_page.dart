import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/providers/cinema_page_provider.dart';
import 'package:myecl/cinema/providers/session_provider.dart';
import 'package:myecl/cinema/tools/functions.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final page = ref.watch(cinemaPageProvider);
    final pageNotifier = ref.watch(cinemaPageProvider.notifier);
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(0, 5),
                ),
              ]),
              child: Image.network(
                session.posterUrl,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (page == CinemaPage.detailFromMainPage) {
                        pageNotifier.setCinemaPage(CinemaPage.main);
                      } else {
                        pageNotifier.setCinemaPage(CinemaPage.admin);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const HeroIcon(
                            HeroIcons.clock,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(formatDuration(session.duration),
                              style: const TextStyle(fontSize: 16)),
                        ],
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 140,
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(0, 255, 255, 255),
                      Colors.grey.shade50.withOpacity(0.85),
                      Colors.grey.shade50,
                    ],
                    stops: const [0.0, 0.65, 1.0],
                  ),
                ),
              ),
              Container(
                color: Colors.grey.shade50,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        session.name,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          session.genre,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      session.overview,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
