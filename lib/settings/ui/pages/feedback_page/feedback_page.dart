import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/settings/class/feedback.dart';
import 'package:titan/settings/providers/feedback_list_provider.dart';
import 'package:titan/settings/router.dart';
import 'package:titan/settings/tools/constants.dart';
import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class FeedbackPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackListNotifier = ref.watch(feedbackListProvider.notifier);
    final provider = ref.watch(feedbackListProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    final feedbackController = useTextEditingController(text: "");

    return SettingsTemplate(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const AlignLeftText(
                SettingsTextConstants.feedback,
                color: Colors.grey,
              ),
              const SizedBox(height: 40),
              AlignLeftText(
                padding: EdgeInsetsGeometry.directional(start: 20),
                SettingsTextConstants.unephrasecettefoisci,
                fontSize: 15,
              ),
              SizedBox(height: 20),
              Expanded(
                child: TextEntry(
                  label: "contentTextEntry",
                  controller: feedbackController,
                  keyboardType: TextInputType.multiline,
                  canBeEmpty: false,
                  autofocus: true,
                  minLines: 4,
                  maxLines: 15,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: SettingsTextConstants.unephrasecettefoisci,
                  ),
                ),
              ),

              WaitingButton(
                builder: (child) => AddEditButtonLayout(
                  colors: const [
                    ColorConstants.gradient1,
                    ColorConstants.gradient2,
                  ],
                  child: child,
                ),
                onTap: () async {
                  await tokenExpireWrapper(ref, () async {
                    final value = await feedbackListNotifier.addFeedback(
                      Feedback.empty().copyWith(
                        content: feedbackController.value.text,
                      ),
                    );

                    if (value) {
                      displayToastWithContext(
                        TypeMsg.msg,
                        SettingsTextConstants.feedbackSent,
                      );
                      QR.removeNavigator(
                        SettingsRouter.root + SettingsRouter.feedback,
                      );
                    } else {
                      displayToastWithContext(
                        TypeMsg.error,
                        SettingsTextConstants.feedbackSendingError,
                      );
                    }
                    QR.back();
                  });
                },
                child: const Center(
                  child: Text(
                    SettingsTextConstants.send,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
