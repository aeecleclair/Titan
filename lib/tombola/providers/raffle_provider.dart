import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tombola/class/raffle.dart';

class RaffleNotifier extends StateNotifier<Raffle> {
  RaffleNotifier() : super(Raffle.empty());

  void setRaffle(Raffle raffle) {
    state = raffle;
  }
}

final raffleProvider = StateNotifierProvider<RaffleNotifier, Raffle>((ref) {
  return RaffleNotifier();
});
