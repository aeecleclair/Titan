import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diacritic/diacritic.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/purchases/providers/purchase_list_provider.dart';
import 'package:myecl/purchases/providers/research_filter_provider.dart';

final purchaseFilteredListProvider = Provider<List<PurchaseReturn>>((ref) {
  final purchasesProvider = ref.watch(purchaseListProvider);
  final searchFilter = ref.watch(filterProvider);
  return purchasesProvider.maybeWhen(
    data: (purchases) {
      return purchases
          .where(
            (purchase) =>
                removeDiacritics(purchase.product.nameFr.toLowerCase())
                    .contains(removeDiacritics(searchFilter.toLowerCase())),
          )
          .toList();
    },
    orElse: () => [],
  );
});
