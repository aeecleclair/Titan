import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/providers/user_provider.dart';

class TextControllersNotifier
    extends StateNotifier<List<TextEditingController>> {
  final List<TextEditingController> list;
  TextControllersNotifier(this.list) : super([]) {
    state = list;
  }

  void disposeAll() {
    for (final controller in state) {
      controller.dispose();
    }
    state = [];
  }

  void updateText(int index, String text) {
    if (index < 0 || index >= state.length) return;
    state[index].text = text;
    state = [...state];
  }
}

final textControllersProvider =
    StateNotifierProvider<TextControllersNotifier, List<TextEditingController>>(
      (ref) {
        final me = ref.watch(userProvider);
        final list = [
          TextEditingController(text: me.email),
          TextEditingController(text: me.phone ?? ""),
          TextEditingController(
            text: me.birthday != null ? processDate(me.birthday!) : "",
          ),
        ];
        return TextControllersNotifier(list);
      },
    );
