import 'package:collection/collection.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/ticketing/providers/category_list_provider.dart';
import 'package:titan/ticketing/providers/session_list_provider.dart';
import 'package:titan/ticketing/providers/session_provider.dart';
import 'package:titan/booking/providers/is_admin_provider.dart';
import 'package:titan/ticketing/ui/components/category_card.dart';
import 'package:titan/ticketing/ui/components/session_card.dart';
import 'package:titan/ticketing/ui/components/event_card.dart';
import 'package:titan/ticketing/ui/ticketing.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/layouts/column_refresher.dart';
import 'package:titan/ticketing/router.dart';
import 'package:titan/ticketing/providers/is_ticketing_admin_provider.dart';
import 'package:titan/ticketing/providers/event_list_provider.dart';
import 'package:titan/ticketing/providers/event_provider.dart';
import 'package:titan/ticketing/ui/pages/main_page/main_page.dart';
import 'package:titan/ticketing/ui/components/announcer_bar.dart';
import 'package:titan/ticketing/tools/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TicketingMainPage extends HookConsumerWidget {
  const TicketingMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = true; //ref.watch(isAdminProvider);

    final eventNotifier = ref.watch(eventProvider.notifier);
    final eventList = ref.watch(eventListProvider);
    final eventListNotifier = ref.watch(eventListProvider.notifier);

    final categoryList = ref.watch(categoryListProvider);
    final categoryListNotifier = ref.watch(categoryListProvider.notifier);

    final sessionNotifier = ref.watch(sessionProvider.notifier);

    final sessionList = ref.watch(sessionListProvider);
    final sessionListNotifier = ref.watch(sessionListProvider.notifier);

    final selectedAnnouncer = ref.watch(announcerProvider);
    final selectedAnnouncerNotifier = ref.watch(announcerProvider.notifier);

    final animation = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0,
    );
    final popAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));

    final showPanel = useState(false);
    final showCategories = useState(false);
    final selectedEvent = useState('');
    final selectedSession = useState('');

    double width = 300;
    double height = 300;
    double imageHeight = 175;
    double maxHeight = MediaQuery.of(context).size.height - 344;

    return TicketingTemplate(
      child: Stack(
        children: [
          AsyncChild(
            value: eventList,
            builder: (context, eventData) {
              final sortedEventData = eventData
                  .sortedBy((element) => element.date)
                  .reversed;
              final filteredSortedEventData = sortedEventData.where(
                (event) =>
                    selectedAnnouncer
                        .where((e) => event.announcer.name == e.name)
                        .isNotEmpty ||
                    selectedAnnouncer.isEmpty,
              );
              return ColumnRefresher(
                onRefresh: () async {
                  await eventListNotifier.loadEvents();
                },
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 40),
                        if (isAdmin)
                          AdminButton(
                            onTap: () {
                              QR.to(
                                TicketingRouter.root + TicketingRouter.admin,
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AnnouncerBar(
                    useUserAnnouncers: false,
                    multipleSelect: true,
                  ),
                  const SizedBox(height: 20),
                  ...filteredSortedEventData.map(
                    (event) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: EventCard(
                        event: event,
                        onTap: () {
                          animation.forward();
                          showPanel.value = true;
                          print("Event tapped: ${event.title}");
                          selectedEvent.value = event.id;
                          eventNotifier.setEvent(event);
                          categoryListNotifier.loadCategories(event.id);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
          AnimatedBuilder(
            builder: (context, child) {
              return Opacity(
                opacity: popAnimation.value,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    (1 - popAnimation.value) *
                        MediaQuery.of(context).size.height,
                  ),
                  child: child,
                ),
              );
            },
            animation: animation,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (showCategories.value)
                              IconButton(
                                icon: const HeroIcon(
                                  HeroIcons.arrowLeft,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  showCategories.value = false;
                                },
                              ),
                            Text(
                              showCategories.value
                                  ? "Liste des catégories"
                                  : "Liste des sessions",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const HeroIcon(
                            HeroIcons.xMark,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            animation.reverse();
                            showPanel.value = false;
                            showCategories.value = false;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (!showCategories.value)
                    sessionList.when(
                      data: (sessions) {
                        final eventSessions = sessions
                            .where(
                              (session) =>
                                  session.eventId == selectedEvent.value,
                            )
                            .toList();
                        if (eventSessions.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("Aucune session disponible."),
                          );
                        }
                        return Column(
                          children: eventSessions.map((session) {
                            return SessionCard(
                              onTap: () {
                                selectedSession.value = session.id;
                                sessionNotifier.setSession(session);
                                showCategories.value = true;
                                print("Session tapped: ${session.name}");
                              },
                              sessionName: session.name,
                            );
                          }).toList(),
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Erreur lors du chargement des sessions."),
                      ),
                    ),
                  if (showCategories.value)
                    categoryList.when(
                      data: (categories) {
                        final filteredCategories = categories
                            .where(
                              (category) => category.linkedSessions.contains(
                                selectedSession.value,
                              ),
                            )
                            .toList();
                        if (filteredCategories.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Aucune catégorie disponible pour cette session.",
                            ),
                          );
                        }
                        return Column(
                          children: filteredCategories.map((category) {
                            return CategoryCard(
                              onTap: () {
                                print("Category tapped: ${category.name}");
                                // TODO: Navigation ou action suivante
                              },
                              categoryName: category.name,
                              categoryPrice: category.price,
                            );
                          }).toList(),
                        );
                      },
                      loading: () => const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Erreur lors du chargement des catégories.",
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
