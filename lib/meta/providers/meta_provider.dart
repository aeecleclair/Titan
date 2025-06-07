import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meta/class/meta.dart';

class MetaNotifier extends StateNotifier<Meta> {
  MetaNotifier() : super(Meta.empty());

  void setMeta(Meta i) {
    state = i;
  }
}

final metaProvider = StateNotifierProvider<MetaNotifier, Meta>((ref) {
  return MetaNotifier();
});
