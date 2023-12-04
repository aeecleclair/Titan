import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/raffle/providers/raffle_list_provider.dart';

class RaffleLogoNotifier extends MapNotifier<RaffleComplete, Image> {
  RaffleLogoNotifier() : super();
}

final tombolaLogosProvider = StateNotifierProvider<RaffleLogoNotifier,
    AsyncValue<Map<RaffleComplete, AsyncValue<List<Image>>>>>((ref) {
  RaffleLogoNotifier raffleLogoNotifier = RaffleLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(raffleListProvider).maybeWhen(data: (raffle) {
      raffleLogoNotifier.loadTList(raffle);
      for (final l in raffle) {
        raffleLogoNotifier.setTData(l, const AsyncValue.data([]));
      }
      return RaffleLogoNotifier;
    }, orElse: () {
      raffleLogoNotifier.loadTList([]);
      return RaffleLogoNotifier;
    });
  });
  return raffleLogoNotifier;
});
