import 'package:flutter_riverpod/flutter_riverpod.dart';

final consumedFilterProvider = NotifierProvider<BoolNotifier, bool>(
  BoolNotifier.new,
);

class BoolNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setBool(bool i) {
    state = i;
  }
}
