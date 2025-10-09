import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/providers/information_provider.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/seed-library/ui/seed_library.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EditInformationPage extends HookConsumerWidget {
  const EditInformationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final informationNotifier = ref.watch(informationProvider.notifier);
    final information = ref.watch(informationProvider);
    final key = GlobalKey<FormState>();

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SeedLibraryTemplate(
      child: AsyncChild(
        value: information,
        builder: (context, syncInformation) {
          final description = TextEditingController(
            text: syncInformation.description,
          );
          final contact = TextEditingController(text: syncInformation.contact);
          final facebookUrl = TextEditingController(
            text: syncInformation.facebookUrl,
          );
          final forumUrl = TextEditingController(
            text: syncInformation.forumUrl,
          );
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        SeedLibraryTextConstants.editInformation,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gradient1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextEntry(
                      controller: description,
                      label: SeedLibraryTextConstants.description,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 20),
                    TextEntry(
                      controller: contact,
                      label: SeedLibraryTextConstants.contact,
                    ),
                    const SizedBox(height: 20),
                    TextEntry(
                      controller: facebookUrl,
                      label: SeedLibraryTextConstants.facebookUrl,
                    ),
                    const SizedBox(height: 20),
                    TextEntry(
                      controller: forumUrl,
                      label: SeedLibraryTextConstants.forumUrl,
                    ),
                    const SizedBox(height: 20),
                    WaitingButton(
                      builder: (child) => AddEditButtonLayout(
                        colors: const [
                          ColorConstants.gradient1,
                          ColorConstants.gradient2,
                        ],
                        child: child,
                      ),
                      onTap: () async {
                        if (!key.currentState!.validate()) {
                          displayToastWithContext(
                            TypeMsg.error,
                            SeedLibraryTextConstants.emptyFieldError,
                          );
                          return;
                        }
                        await tokenExpireWrapper(ref, () async {
                          final value = await informationNotifier
                              .updateInformation(
                                syncInformation.copyWith(
                                  description: description.text,
                                  contact: contact.text,
                                  facebookUrl: facebookUrl.text,
                                  forumUrl: forumUrl.text,
                                ),
                              );
                          if (value) {
                            displayToastWithContext(
                              TypeMsg.msg,
                              SeedLibraryTextConstants.updatedInformation,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.error,
                              SeedLibraryTextConstants.updatingError,
                            );
                          }
                          QR.back();
                        });
                      },
                      child: Text(
                        SeedLibraryTextConstants.update,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
