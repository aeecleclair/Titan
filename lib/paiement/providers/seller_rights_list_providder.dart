import 'package:hooks_riverpod/hooks_riverpod.dart';

class SellerRightsListNotifier extends StateNotifier<List<bool>> {
  SellerRightsListNotifier() : super([true, false, false, false]);

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
    StateNotifierProvider<SellerRightsListNotifier, List<bool>>((ref) {
      return SellerRightsListNotifier();
    });
