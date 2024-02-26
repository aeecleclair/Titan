import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(phonebookPageProvider);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        switch (page) {
                          case PhonebookPage.main:
                            controllerNotifier.toggle();
                            break;
                          case PhonebookPage.memberDetail:
                            pageNotifier.setPhonebookPage(PhonebookPage.associationPage);
                            break;
                          case PhonebookPage.admin:
                            pageNotifier.setPhonebookPage(PhonebookPage.main);
                            break;
                          case PhonebookPage.associationEditor:
                            pageNotifier.setPhonebookPage(PhonebookPage.admin);
                            break;
                          case PhonebookPage.associationPage:
                            pageNotifier.setPhonebookPage(PhonebookPage.main);
                            break;
                          case PhonebookPage.associationCreation:
                            pageNotifier.setPhonebookPage(PhonebookPage.admin);
                            break;
                          case PhonebookPage.membershipEdition:
                            pageNotifier.setPhonebookPage(PhonebookPage.associationEditor);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == PhonebookPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(PhonebookTextConstants.phonebook,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
