import 'package:collection/collection.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:titan/advert/providers/announcer_provider.dart';
import 'package:titan/ticketing/providers/category_list_provider.dart';
import 'package:titan/booking/providers/is_admin_provider.dart';
import 'package:titan/ticketing/ui/components/category_card.dart';
import 'package:titan/ticketing/ui/components/event_card.dart';
import 'package:titan/ticketing/ui/ticketing.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/widgets/admin_button.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
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

    final selected = ref.watch(announcerProvider);
    final selectedNotifier = ref.watch(announcerProvider.notifier);

    final animation = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: 0,
    );
    final popAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));
    final showPanel = useState(false);

    final selectedEvent = useState('');

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
                    selected
                        .where((e) => event.announcer.name == e.name)
                        .isNotEmpty ||
                    selected.isEmpty,
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
                color: Colors.white, // Ajout d'une couleur de fond
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
                        const Text(
                          "Liste des Catégories",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
                          },
                        ),
                      ],
                    ),
                  ),
                  categoryList.when(
                    data: (categories) {
                      final eventCategories = categories
                          .where(
                            (category) =>
                                category.eventId == selectedEvent.value,
                          )
                          .toList();
                      if (eventCategories.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Aucune catégorie disponible."),
                        );
                      }
                      return Column(
                        children: eventCategories.map((category) {
                          return CategoryCard(
                            onTap: () {
                              // Handle category tap
                              print(
                                "Category tapped: ${category.name} for event ${category.eventId}",
                              );
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
                    error: (error, stack) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("Erreur lors du chargement des catégories."),
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
