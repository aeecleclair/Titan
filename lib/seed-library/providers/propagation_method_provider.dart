import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/seed-library/class/plant_simple.dart';

final propagationMethodProvider =
    StateNotifierProvider<PropagationMethodNotifier, PropagationMethod>((ref) {
  return PropagationMethodNotifier();
});

class PropagationMethodNotifier extends StateNotifier<PropagationMethod> {
  PropagationMethodNotifier() : super(PropagationMethod.graine);

  void setPropagationMethod(PropagationMethod i) {
    state = i;
  }
}
