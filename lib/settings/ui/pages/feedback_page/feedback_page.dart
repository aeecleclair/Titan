import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/settings/tools/constants.dart';
import 'package:titan/settings/ui/settings.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';

class FeedbackPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  label: "",
                  controller: useTextEditingController(),
                  keyboardType: TextInputType.multiline,
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
                  //todo
                  // await tokenExpireWrapper(ref, () async {
                  //   final value = await asyncUserNotifier.updateMe(
                  //     user.copyWith(
                  //       birthday: dateController.value.text.isNotEmpty
                  //           ? DateTime.parse(
                  //               processDateBack(dateController.value.text),
                  //             )
                  //           : null,
                  //       nickname: nickNameController.value.text.isEmpty
                  //           ? null
                  //           : nickNameController.value.text,
                  //       phone: phoneController.value.text.isEmpty
                  //           ? null
                  //           : phoneController.value.text,
                  //       floor: floorController.value.text,
                  //     ),
                  //   );
                  //   if (value) {
                  //     displayToastWithContext(
                  //       TypeMsg.msg,
                  //       SettingsTextConstants.updatedProfile,
                  //     );
                  //     QR.removeNavigator(
                  //       SettingsRouter.root + SettingsRouter.editAccount,
                  //     );
                  //   } else {
                  //     displayToastWithContext(
                  //       TypeMsg.error,
                  //       SettingsTextConstants.updatingError,
                  //     );
                  //   }
                  // });
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
