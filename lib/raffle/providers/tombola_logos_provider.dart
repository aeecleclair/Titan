import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/raffle/class/raffle.dart';

class RaffleLogoNotifier extends MapNotifier<Raffle, Image> {
  RaffleLogoNotifier() : super();
}

final tombolaLogosProvider = StateNotifierProvider<RaffleLogoNotifier,
    Map<Raffle, AsyncValue<List<Image>>?>>((ref) {
  RaffleLogoNotifier raffleLogoNotifier = RaffleLogoNotifier();
  return raffleLogoNotifier;
});
