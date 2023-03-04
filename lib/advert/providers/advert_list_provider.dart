import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/repositories/advert_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AdvertListNotifier extends ListNotifier<Advert> {
  AdvertRepository repository = AdvertRepository();
  AdvertListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Advert>>> loadAdverts() async {
    //return await loadList(repository.getAdverts);
    return state = AsyncData([
      Advert(
          id: '1',
          author: 'moi',
          content:
              '''ibus accumsan. Vivamus id sollicitudin nunc, eget ornare neque. Suspendisse aliquet, justo eu suscipit varius, neque tortor tempus leo, a consectetur turpis ante et elit. Aenean aliquet dolor id sem condimentum, at pellentesque enim ornare. Sed tempus nisl at turpis egestas, id imperdiet dolor tincidunt. Nam a enim in dui facilisis placerat. Pellentesque vel magna a ipsum dignissim convallis ac nec velit. Donec rutrum vulputate leo, vel mattis orci varius nec. Quisque nec elit pellentesque, bibendum eros vitae, blandit metus. ''',
          title: 'C\'est mon titre à moi',
          date: DateTime.now(),
          announcer: ['Eclair'],
          tags: ['tag1', "tag2", 'tag3']),
      Advert(
          id: '2',
          author: 'moi',
          content: 'Salut à tous !',
          title: 'C\'est mon titre à moi',
          date: DateTime.now(),
          announcer: ['Raid'],
          tags: ['tag1', "tag2", 'tag3']),
      Advert(
          id: '3',
          author: 'moi',
          content: 'Salut à tous !',
          title: 'C\'est mon titre à moi',
          date: DateTime.now(),
          announcer: ['Eclair'],
          tags: ['tag1', "tag2", 'tag3']),
      Advert(
          id: '4',
          author: 'oui',
          content: 'Le contenu de ding!',
          title: 'Aujourd\'hui on s\'amuse bcp',
          date: DateTime.now(),
          announcer: ['Eclair'],
          tags: ['tag1', "tag3"]),
      Advert(
          id: '5',
          author: 'Chef',
          content:
              '''ibus accumsan. Vivamus id sollicitudin nunc, eget ornare neque. Suspendisse aliquet, justo eu suscipit varius, neque tortor tempus leo, a consectetur turpis ante et elit. Aenean aliquet dolor id sem condimentum, at pellentesque enim ornare. Sed tempus nisl at turpis egestas, id imperdiet dolor tincidunt. Nam a enim in dui facilisis placerat. Pellentesque vel magna a ipsum dignissim convallis ac nec velit. Donec rutrum vulputate leo, vel mattis orci varius nec. Quisque nec elit pellentesque, bibendum eros vitae, blandit metus. ''',
          title: 'Vive les fusées !!!',
          date: DateTime.now(),
          announcer: ['Cosmos'],
          tags: ['tag3', "tag4"]),
      Advert(
          id: '6',
          author: 'JE',
          content:
              '''ibus accumsan. Vivamus id sollicitudin nunc, eget ornare neque. Suspendisse aliquet, justo eu suscipit varius, neque tortor tempus leo, a consectetur turpis ante et elit. Aenean aliquet dolor id sem condimentum, at pellentesque enim ornare. Sed tempus nisl at turpis egestas, id imperdiet dolor tincidunt. Nam a enim in dui facilisis placerat. Pellentesque vel magna a ipsum dignissim convallis ac nec velit. Donec rutrum vulputate leo, vel mattis orci varius nec. Quisque nec elit pellentesque, bibendum eros vitae, blandit metus. ''',
          title: 'Serious Business.',
          date: DateTime.now(),
          announcer: ['JE'],
          tags: ['tag3', "tag4"])
    ]);
  }

  Future<bool> addAdvert(Advert advert) async {
    return await add(repository.addAdvert, advert);
  }

  Future<bool> updateAdvert(Advert advert) async {
    return await update(
        repository.updateAdvert,
        (adverts, advert) =>
            adverts..[adverts.indexWhere((b) => b.id == advert.id)] = advert,
        advert);
  }

  Future<bool> deleteAdvert(Advert advert) async {
    return await delete(
        repository.deleteAdvert,
        (adverts, advert) => adverts..removeWhere((b) => b.id == advert.id),
        advert.id,
        advert);
  }
}

final advertListProvider =
    StateNotifierProvider<AdvertListNotifier, AsyncValue<List<Advert>>>((ref) {
  final token = ref.watch(tokenProvider);
  AdvertListNotifier notifier = AdvertListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadAdverts();
  });
  return notifier;
});
