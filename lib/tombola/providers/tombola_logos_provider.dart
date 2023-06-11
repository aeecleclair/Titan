import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/providers/raffle_list_provider.dart';

class RaffleLogoNotifier extends MapNotifier<Raffle, Image> {
  RaffleLogoNotifier() : super();
}

final tombolaLogosProvider = StateNotifierProvider<RaffleLogoNotifier,
    AsyncValue<Map<Raffle, AsyncValue<List<Image>>>>>((ref) {
  RaffleLogoNotifier raffleLogoNotifier =
  RaffleLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(raffleListProvider).when(data: (raffle) {
      raffleLogoNotifier.loadTList(raffle);
      for (final l in raffle) {
        raffleLogoNotifier.setTData(l, const AsyncValue.data([]));
      }
      return RaffleLogoNotifier;
    }, error: (error, stackTrace) {
      raffleLogoNotifier.loadTList([]);
      return RaffleLogoNotifier;
    }, loading: () {
      raffleLogoNotifier.loadTList([]);
      return RaffleLogoNotifier;
    });
  });
  return raffleLogoNotifier;
});
