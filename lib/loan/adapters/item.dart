import 'package:myecl/generated/openapi.models.swagger.dart';

extension $Item on Item {
  ItemBase toItemBase() {
    return ItemBase(
        name: name,
        suggestedCaution: suggestedCaution,
        totalQuantity: totalQuantity,
        suggestedLendingDuration: suggestedLendingDuration);
  }

  ItemSimple toItemSimple() {
    return ItemSimple(
      id: id,
      name: name,
      loanerId: loanerId,
    );
  }

  ItemUpdate toItemUpdate() {
    return ItemUpdate(
      name: name,
      suggestedCaution: suggestedCaution,
      totalQuantity: totalQuantity,
      suggestedLendingDuration: suggestedLendingDuration,
    );
  }
}

extension $ItemSimple on ItemSimple {
  ItemBorrowed toItemBorrowed(int quantity) {
    return ItemBorrowed(itemId: id, quantity: quantity);
  }
}
