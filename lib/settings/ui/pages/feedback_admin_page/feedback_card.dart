import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/settings/providers/feedback_list_provider.dart';
import 'package:titan/settings/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/settings/class/feedback.dart';

class FeedbackCard extends HookConsumerWidget {
  final Feedback feedback;
  const FeedbackCard({super.key, required this.feedback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(feedbackListProvider.notifier);
    final isChecked = useState(feedback.isAddressed);
    final textColor = isChecked.value ? Colors.grey : Colors.black;
    final dateColor = isChecked.value ? Colors.grey : Colors.grey;

    return GestureDetector(
      child: CardLayout(
        color: SettingsColorConstants.cardColor,
        shadowColor: SettingsColorConstants.shadowColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AutoSizeText(
                        capitalize(
                          feedback.userName == ""
                              ? feedback.userId
                              : feedback.userName,
                        ),
                        maxLines: 1,
                        minFontSize: 10,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AutoSizeText(
                        DateFormat(
                          'dd-MM-yyyy - HH:mm',
                        ).format(feedback.creation),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13, color: dateColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    notifier.deleteFeedback(feedback);
                  },
                  icon: HeroIcon(HeroIcons.trash, size: 28, color: Colors.red),
                ),

                const SizedBox(width: 5),
                Checkbox(
                  value: isChecked.value,
                  onChanged: (bool? newValue) {
                    isChecked.value = newValue ?? false;
                    //isChecked = newValue;
                    //todo use notifier to edit feedback
                  },
                ),
              ],
            ),

            AutoSizeText(
              feedback.content,

              style: TextStyle(fontSize: 18, color: textColor),
              textAlign: TextAlign.justify,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
