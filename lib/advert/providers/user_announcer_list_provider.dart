import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/advert/class/announcer.dart';
import 'package:myecl/advert/repositories/announcer_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserAnnouncerListNotifier extends ListNotifier<Announcer> {
  final AnnouncerRepository _announcerRepository = AnnouncerRepository();
  UserAnnouncerListNotifier({required String token})
      : super(const AsyncValue.loading()) {
        _announcerRepository.setToken(token);
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
            announcers..[announcers.indexWhere((i) => i.id == announcer.id)] = announcer,
        announcer);
  }

  Future<bool> deleteAnnouncer(Announcer announcer) async {
    return await delete(
        _announcerRepository.deleteAnnouncer,
        (adverts, advert) => adverts..removeWhere((i) => i.id == advert.id),
        announcer.id,
        announcer);
  }
}

final userAnnouncerListProvider =
    StateNotifierProvider<UserAnnouncerListNotifier, AsyncValue<List<Announcer>>>(
  (ref) {
    final token = ref.watch(tokenProvider);
    UserAnnouncerListNotifier orderListNotifier =
        UserAnnouncerListNotifier(token: token);
    tokenExpireWrapperAuth(ref, () async {
      await orderListNotifier.loadMyAnnouncerList();
    });
    return orderListNotifier;
  },
);

final announcerList = Provider<List<Announcer>>((ref) {
  final deliveryProvider = ref.watch(userAnnouncerListProvider);
  return deliveryProvider.when(
      data: (adverts) => adverts,
      error: (error, stackTrace) => [],
      loading: () => []);
});
