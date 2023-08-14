import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';


class AdvertPosterNotifier extends MapNotifier<Advert, Image> {
  AdvertPosterNotifier() : super();
}

final advertPostersProvider = StateNotifierProvider<AdvertPosterNotifier,
    AsyncValue<Map<Advert, AsyncValue<List<Image>>>>>((ref) {
  AdvertPosterNotifier advertPosterNotifier =
      AdvertPosterNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(advertListProvider).when(data: (advert) {
      advertPosterNotifier.loadTList(advert);
      for (final l in advert) {
        advertPosterNotifier.setTData(l, const AsyncValue.data([]));
      }
      return advertPosterNotifier;
    }, error: (error, stackTrace) {
      advertPosterNotifier.loadTList([]);
      return advertPosterNotifier;
    }, loading: () {
      advertPosterNotifier.loadTList([]);
      return advertPosterNotifier;
    });
  });
  return advertPosterNotifier;
});
