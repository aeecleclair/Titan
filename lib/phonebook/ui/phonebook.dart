import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/phonebook/providers/phonebook_page_provider.dart';
import 'package:myecl/phonebook/ui/page_switcher.dart';
import 'package:myecl/phonebook/ui/top_bar.dart';

class PhonebookHomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const PhonebookHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(phonebookPageProvider);
    final pageNotifier = ref.watch(phonebookPageProvider.notifier);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          switch (page) {
            case PhonebookPage.main:
              if (!controller.isCompleted) {
                controllerNotifier.toggle();
                break;
              } else {
                return true;
              }
            case PhonebookPage.memberDetail:
              pageNotifier.setPhonebookPage(PhonebookPage.main);
              break;
            case PhonebookPage.addEditAssociation:
              pageNotifier.setPhonebookPage(PhonebookPage.admin);
              break;
            case PhonebookPage.admin:
              pageNotifier.setPhonebookPage(PhonebookPage.main);
              break;
            case PhonebookPage.addEditRoleMember:
              pageNotifier.setPhonebookPage(PhonebookPage.memberDetail);
              break;
            case PhonebookPage.editRole:
              pageNotifier.setPhonebookPage(PhonebookPage.admin);
              break;
            case PhonebookPage.associationEditor:
              pageNotifier.setPhonebookPage(PhonebookPage.addEditAssociation);
              break;
          }
          return false;
        },
        child: SafeArea(
          child: IgnorePointer(
            ignoring: controller.isCompleted,
            child: Column(
              children: [
                TopBar(
                  controllerNotifier: controllerNotifier,
                ),
                const Expanded(child: PageSwitcher()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
