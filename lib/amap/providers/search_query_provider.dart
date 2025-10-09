import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchingQueryNotifier extends StateNotifier<TextEditingController> {
  SearchingQueryNotifier() : super(useTextEditingController());

  void clear(bool value) {
    state.clear();
  }
}

final searchingQueryProvider =
    StateNotifierProvider<SearchingQueryNotifier, TextEditingController>((ref) {
      return SearchingQueryNotifier();
    });
