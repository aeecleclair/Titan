import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/shotgun/class/shotgun.dart';

class ShotgunNotifier extends StateNotifier<Shotgun> {
  ShotgunNotifier() : super(Shotgun.empty());

  void setShotgun(Shotgun i) {
    state = i;
  }
}

final shotgunProvider = StateNotifierProvider<ShotgunNotifier, Shotgun>((ref) {
  return ShotgunNotifier();
});
