import 'package:myecl/generated/openapi.models.swagger.dart';

CoreUserUpdateAdmin coreUserUpdateAdminAdapter(CoreUser coreUser) {
  return CoreUserUpdateAdmin(
    name: coreUser.name,
    firstname: coreUser.firstname,
    promo: coreUser.promo,
    nickname: coreUser.nickname,
    birthday: coreUser.birthday,
    phone: coreUser.phone,
    floor: coreUser.floor,
  );
}

CoreUserUpdate coreUserUpdateAdapter(CoreUser coreUser) {
  return CoreUserUpdate(
    nickname: coreUser.nickname,
    birthday: coreUser.birthday,
    phone: coreUser.phone,
    floor: coreUser.floor,
  );
}
