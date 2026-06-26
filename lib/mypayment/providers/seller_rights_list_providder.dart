import 'package:hooks_riverpod/hooks_riverpod.dart';

class SellerRightsListNotifier extends Notifier<List<bool>> {
  @override
  List<bool> build() {
    return [true, false, false, false];
  }

  void updateRights(int index, bool value) {
    final updatedRights = List<bool>.from(state);
    updatedRights[index] = value;
    state = updatedRights;
  }

  void clearRights() {
    state = [true, false, false, false];
  }
}

final sellerRightsListProvider =
    NotifierProvider<SellerRightsListNotifier, List<bool>>(
      SellerRightsListNotifier.new,
    );
