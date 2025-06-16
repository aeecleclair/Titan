import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/advert/repositories/announcer_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class AnnouncerListNotifier extends ListNotifier<Announcer> {
  final AnnouncerRepository _announcerRepository;
  AnnouncerListNotifier(this._announcerRepository)
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Announcer>>> loadAllAnnouncerList() async {
    return await loadList(_announcerRepository.getAllAnnouncer);
  }

  Future<AsyncValue<List<Announcer>>> loadMyAnnouncerList() async {
    return await loadList(_announcerRepository.getMyAnnouncer);
  }

  Future<bool> addAnnouncer(Announcer announcer) async {
    return await add(_announcerRepository.createAnnouncer, announcer);
  }

  Future<bool> updateAnnouncer(Announcer announcer) async {
    return await update(
      _announcerRepository.updateAnnouncer,
      (announcers, announcer) =>
          announcers
            ..[announcers.indexWhere((i) => i.id == announcer.id)] = announcer,
      announcer,
    );
  }

  Future<bool> deleteAnnouncer(Announcer announcer) async {
    return await delete(
      _announcerRepository.deleteAnnouncer,
      (adverts, advert) => adverts..removeWhere((i) => i.id == advert.id),
      announcer.id,
      announcer,
    );
  }
}

final announcerListProvider =
    StateNotifierProvider<AnnouncerListNotifier, AsyncValue<List<Announcer>>>((
      ref,
    ) {
      final repository = ref.watch(announcerRepositoryProvider);
      AnnouncerListNotifier announcerListNotifier = AnnouncerListNotifier(
        repository,
      );
      announcerListNotifier.loadAllAnnouncerList();
      return announcerListNotifier;
    });

final userAnnouncerListProvider =
    StateNotifierProvider<AnnouncerListNotifier, AsyncValue<List<Announcer>>>((
      ref,
    ) {
      final repository = ref.watch(announcerRepositoryProvider);
      AnnouncerListNotifier announcerListNotifier = AnnouncerListNotifier(
        repository,
      );
      announcerListNotifier.loadMyAnnouncerList();
      return announcerListNotifier;
    });
