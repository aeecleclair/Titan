import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchingAmapUserNotifier extends StateNotifier<bool> {
  SearchingAmapUserNotifier() : super(true);

  void setProduct(bool value) {
    state = value;
  }
}

final searchingAmapUserProvider =
    StateNotifierProvider<SearchingAmapUserNotifier, bool>((ref) {
      return SearchingAmapUserNotifier();
    });
