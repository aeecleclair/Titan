import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/advert/class/announcer.dart';

final announcerProvider =
    StateNotifierProvider<AnnouncerNotifier, List<Announcer>>((ref) {
      return AnnouncerNotifier();
    });

class AnnouncerNotifier extends StateNotifier<List<Announcer>> {
  AnnouncerNotifier() : super([]);

  void addAnnouncer(Announcer i) {
    state.add(i);
    state = state.sublist(0);
  }

  void removeAnnouncer(Announcer i) {
    state = state.where((element) => element.id != i.id).toList();
  }

  void clearAnnouncer() {
    state = [];
  }
}
