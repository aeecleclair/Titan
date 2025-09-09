import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/feed/class/event.dart';
import 'package:titan/feed/providers/association_event_list_provider.dart';
import 'package:titan/feed/providers/event_image_provider.dart';
import 'package:titan/feed/providers/event_provider.dart';
import 'package:titan/feed/router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/confirm_modal.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class AssociationEventCard extends ConsumerWidget {
  final Event event;
  const AssociationEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(eventProvider.notifier);
    final associationEventsListNotifier = ref.watch(
      associationEventsListProvider.notifier,
    );
    final eventImageNotifier = ref.watch(eventImageProvider.notifier);

    final localizeWithContext = AppLocalizations.of(context)!;

    return ListItem(
      title: event.name,
      subtitle: event.location,
      onTap: () => showCustomBottomModal(
        context: context,
        modal: BottomModalTemplate(
          title: event.name,
          child: Column(
            children: [
              Button(
                text: localizeWithContext.eventEdit,
                onPressed: () {
                  eventNotifier.setEvent(event);
                  eventImageNotifier.getEventImage(event.id);
                  QR.to(FeedRouter.root + FeedRouter.addEditEvent);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 10),
              Button.danger(
                text: localizeWithContext.eventDelete,
                onPressed: () async {
                  Navigator.of(context).pop();
                  showCustomBottomModal(
                    context: context,
                    modal: ConfirmModal(
                      title: localizeWithContext.eventDeleteConfirm(event.name),
                      description: localizeWithContext.globalIrreversibleAction,
                      onYes: () async {
                        await associationEventsListNotifier.deleteEvent(event);
                      },
                    ),
                    ref: ref,
                  );
                },
              ),
            ],
          ),
        ),
        ref: ref,
      ),
    );
  }
}
