import 'package:titan/generated/openapi.models.swagger.dart';

extension $StoreToUserStore on Store {
  UserStore toUserStore() {
    return UserStore(
      name: name,
      associationId: associationId,
      id: id,
      structureId: structureId,
      walletId: walletId,
      creation: creation,
      structure: structure,
      canBank: false,
      canSeeHistory: false,
      canCancel: false,
      canManageSellers: false,
    );
  }
}
