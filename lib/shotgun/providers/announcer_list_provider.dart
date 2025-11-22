import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/advert/class/announcer.dart';
import 'package:titan/advert/repositories/announcer_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AnnouncerListNotifier extends ListNotifier<Announcer> {
  final AnnouncerRepository _announcerRepository = AnnouncerRepository();
  AnnouncerListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _announcerRepository.setToken(token);
  }

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
      final token = ref.watch(tokenProvider);
      AnnouncerListNotifier announcerListNotifier = AnnouncerListNotifier(
        token: token,
      );
      tokenExpireWrapperAuth(ref, () async {
        await announcerListNotifier.loadAllAnnouncerList();
      });
      return announcerListNotifier;
    });

final userAnnouncerListProvider =
    StateNotifierProvider<AnnouncerListNotifier, AsyncValue<List<Announcer>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      AnnouncerListNotifier announcerListNotifier = AnnouncerListNotifier(
        token: token,
      );
      tokenExpireWrapperAuth(ref, () async {
        await announcerListNotifier.loadMyAnnouncerList();
      });
      return announcerListNotifier;
    });
