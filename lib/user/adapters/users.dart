import 'package:myecl/generated/openapi.models.swagger.dart';

extension $CoreUser on CoreUser {
  CoreUserUpdateAdmin toCoreUserUpdateAdmin() {
    return CoreUserUpdateAdmin(
      name: name,
      firstname: firstname,
      promo: promo,
      nickname: nickname,
      birthday: birthday,
      phone: phone,
      floor: floor,
    );
  }

  CoreUserUpdate toCoreUserUpdate() {
    return CoreUserUpdate(
      nickname: nickname,
      birthday: birthday,
      phone: phone,
      floor: floor,
    );
  }
}
