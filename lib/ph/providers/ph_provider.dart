import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/ph/class/ph.dart';

class PhNotifier extends StateNotifier<Ph> {
  PhNotifier() : super(Ph.empty());

  void setPh(Ph ph) {
    state = ph;
  }
}

final phProvider = StateNotifierProvider<PhNotifier, Ph>((ref) {
  return PhNotifier();
});
