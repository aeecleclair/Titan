import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/class/announcer.dart';


final announcerProvider =
    StateNotifierProvider<AnnouncerNotifier, List<Announcer>>((ref) {
  return AnnouncerNotifier();
});

class AnnouncerNotifier extends StateNotifier<List<Announcer>> {
  AnnouncerNotifier() : super([]);

  void addAnnouncer(Announcer i) {
    final copy = state.sublist(0);
    copy.add(i);
    state = copy;
  }
  void removeAnnouncer(Announcer i) {
    final copy = state.sublist(0);
    state = copy.where((element) => element.id != i.id,).toList();
  }
  void clearAnnouncer() {
    state = [];
  }
}