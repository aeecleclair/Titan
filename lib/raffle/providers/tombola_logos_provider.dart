import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/raffle/class/raffle.dart';
import 'package:myecl/raffle/providers/raffle_list_provider.dart';

class RaffleLogoNotifier extends MapNotifier<Raffle, Image> {
  RaffleLogoNotifier() : super();
}

final tombolaLogosProvider = StateNotifierProvider<RaffleLogoNotifier,
    Map<Raffle, AsyncValue<List<Image>>?>>((ref) {
  RaffleLogoNotifier raffleLogoNotifier = RaffleLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(raffleListProvider).maybeWhen(data: (raffle) {
      raffleLogoNotifier.loadTList(raffle);
      return RaffleLogoNotifier;
    }, orElse: () {
      raffleLogoNotifier.loadTList([]);
      return RaffleLogoNotifier;
    });
  });
  return raffleLogoNotifier;
});
