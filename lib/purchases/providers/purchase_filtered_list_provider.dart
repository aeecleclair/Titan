import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diacritic/diacritic.dart';
import 'package:titan/purchases/class/purchase.dart';
import 'package:titan/purchases/providers/purchase_list_provider.dart';
import 'package:titan/purchases/providers/research_filter_provider.dart';

final purchaseFilteredListProvider = Provider<List<Purchase>>((ref) {
  final purchasesProvider = ref.watch(purchaseListProvider);
  final searchFilter = ref.watch(filterProvider);
  return purchasesProvider.maybeWhen(
    data: (purchases) {
      return purchases
          .where(
            (purchase) => removeDiacritics(
              purchase.product.nameFR.toLowerCase(),
            ).contains(removeDiacritics(searchFilter.toLowerCase())),
          )
          .toList();
    },
    orElse: () => [],
  );
});
