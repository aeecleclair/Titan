import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/vote/class/contender.dart';

final contenderProvider = StateNotifierProvider<ContenderNotifier, Contender>((
  ref,
) {
  return ContenderNotifier();
});

class ContenderNotifier extends StateNotifier<Contender> {
  ContenderNotifier() : super(Contender.empty());

  void setId(Contender p) {
    state = p;
  }
}
