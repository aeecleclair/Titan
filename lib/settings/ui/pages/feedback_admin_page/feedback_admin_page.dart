import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/settings/class/feedback.dart';
import 'package:titan/settings/providers/feedback_list_provider.dart';
import 'package:titan/settings/ui/pages/feedback_admin_page/feedback_card.dart';
import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';

class FeedbackAdminPage extends HookConsumerWidget {
  const FeedbackAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackListNotifier = ref.watch(feedbackListProvider.notifier);
    final feedbackListProv = ref.watch(feedbackListProvider);
    int n = 0;

    List<Feedback> feedbackList = [];

    final feedbackController = useTextEditingController(text: "");

    feedbackListProv.maybeWhen(
      data: (data) {
        if (data.isNotEmpty) {
          for (Feedback l in data) {
            feedbackList.add(l);
          }
          feedbackList.sort((a, b) => b.creation.compareTo(a.creation));
          n = feedbackList.length;
        }
      },
      orElse: () {},
    );

    return SettingsTemplate(
      child: Stack(
        children: [
          Refresher(
            onRefresh: () async {
              await feedbackListNotifier.getFeedbackList();
            },
            child: Column(
              children: [
                const SizedBox(height: 30),
                AlignLeftText(
                  '$n feedback${n > 1 ? 's' : ''} envoyés',
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  color: Colors.grey,
                ),
                const SizedBox(height: 30),
                ListView.builder(
                  itemCount: feedbackList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: FeedbackCard(feedback: feedbackList[index]),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
