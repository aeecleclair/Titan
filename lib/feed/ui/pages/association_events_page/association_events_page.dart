import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/my_association_list_provider.dart';
import 'package:titan/feed/providers/association_event_list_provider.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/feed/ui/pages/association_events_page/association_event_card.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/horizontal_multi_select.dart';

class ManageAssociationEventPage extends HookConsumerWidget {
  const ManageAssociationEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myAssociations = ref.watch(myAssociationListProvider);
    final associationEventsList = ref.watch(associationEventsListProvider);
    final associationEventsListNotifier = ref.watch(
      associationEventsListProvider.notifier,
    );
    final selectedAssociation = useState<Association?>(
      myAssociations.isNotEmpty ? myAssociations.first : null,
    );

    final localizeWithContext = AppLocalizations.of(context)!;

    return FeedTemplate(
      child: Refresher(
        onRefresh: () {
          if (selectedAssociation.value == null) {
            return Future.value();
          }
          return associationEventsListNotifier.loadAssociationEventList(
            selectedAssociation.value!.id,
          );
        },
        controller: ScrollController(),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: HorizontalMultiSelect<Association>(
                items: myAssociations,
                selectedItem: selectedAssociation.value,
                onItemSelected: (association) {
                  selectedAssociation.value = association;
                  associationEventsListNotifier.loadAssociationEventList(
                    association.id,
                  );
                },
                itemBuilder: (context, association, index, selected) => Text(
                  association.name,
                  style: TextStyle(
                    color: selected
                        ? ColorConstants.background
                        : ColorConstants.tertiary,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              localizeWithContext.feedManageAssociationEvents,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.title,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AsyncChild(
                value: associationEventsList,
                builder: (context, eventList) {
                  if (eventList.isEmpty) {
                    return Center(
                      child: Text(
                        localizeWithContext.feedNoAssociationEvents,
                        style: const TextStyle(color: ColorConstants.tertiary),
                      ),
                    );
                  }
                  return ScrollToHideNavbar(
                    controller: ScrollController(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: eventList
                            .map((event) => AssociationEventCard(event: event))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
