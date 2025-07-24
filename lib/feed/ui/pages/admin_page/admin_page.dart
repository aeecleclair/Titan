import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/feed/ui/pages/admin_page/event_form.dart';
import 'package:titan/feed/ui/pages/admin_page/post_form.dart';
import 'package:titan/feed/ui/pages/admin_page/tab_navigation.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use hooks to manage tab selection state
    final selectedTabIndex = useState(0);
    final previousTabIndex = useRef<int>(0);
    final pageController = usePageController();

    // Controllers for Post form
    final postTitleController = useTextEditingController();
    final postDescriptionController = useTextEditingController();
    final postStartDateController = useTextEditingController();

    // Controllers for Event form
    final eventTitleController = useTextEditingController();
    final eventDescriptionController = useTextEditingController();
    final eventLocationController = useTextEditingController();
    final shotgunDateController = useTextEditingController();
    final eventExternalLinkController = useTextEditingController();

    // Selected date state for event
    final eventStartDateController = useTextEditingController();
    final eventEndDateController = useTextEditingController();

    // Handle tab selection changes
    useEffect(() {
      if (pageController.hasClients) {
        pageController.animateToPage(
          selectedTabIndex.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
      return null;
    }, [selectedTabIndex.value]);

    return FeedTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tab Bar
          TabNavigation(
            selectedTabIndex: selectedTabIndex.value,
            onTabChanged: (index) {
              previousTabIndex.value = selectedTabIndex.value;
              selectedTabIndex.value = index;
            },
            tabLabels: const ['Post', 'Événement'],
          ),

          const SizedBox(height: 30),

          // PageView for tab content with actual PageView widget
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                previousTabIndex.value = selectedTabIndex.value;
                selectedTabIndex.value = index;
              },
              children: [
                // Post form
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: PostForm(
                    titleController: postTitleController,
                    descriptionController: postDescriptionController,
                    startDateController: postStartDateController,
                  ),
                ),

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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
