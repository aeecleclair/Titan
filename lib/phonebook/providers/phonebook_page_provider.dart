import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PhonebookPage { main, admin, memberDetail, addEditRoleMember, editRole, associationEditor, associationPage, associationCreation}


final phonebookPageProvider = StateNotifierProvider<PhonebookPageNotifier, PhonebookPage>((ref) {
  return PhonebookPageNotifier();
});

class PhonebookPageNotifier extends StateNotifier<PhonebookPage> {
  PhonebookPageNotifier() : super(PhonebookPage.main);

  void setPhonebookPage(PhonebookPage i) {
    state = i;
  }
}