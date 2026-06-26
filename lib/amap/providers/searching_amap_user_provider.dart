import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchingAmapUserNotifier extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  void setProduct(bool value) {
    state = value;
  }
}

final searchingAmapUserProvider =
    NotifierProvider<SearchingAmapUserNotifier, bool>(
      SearchingAmapUserNotifier.new,
    );
