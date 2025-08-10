import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/feed/ui/pages/admin_page/event_form.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controllers for Event form
    final eventTitleController = useTextEditingController();
    final eventDescriptionController = useTextEditingController();
    final eventLocationController = useTextEditingController();
    final shotgunDateController = useTextEditingController();
    final eventExternalLinkController = useTextEditingController();

    // Selected date state for event
    final eventStartDateController = useTextEditingController();
    final eventEndDateController = useTextEditingController();

    return FeedTemplate(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  // Event form
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: EventForm(
                      titleController: eventTitleController,
                      descriptionController: eventDescriptionController,
                      startDateController: eventStartDateController,
                      endDateController: eventEndDateController,
                      locationController: eventLocationController,
                      shotgunDateController: shotgunDateController,
                      externalLinkController: eventExternalLinkController,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
