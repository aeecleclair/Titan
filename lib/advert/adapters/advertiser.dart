import 'package:myecl/generated/openapi.models.swagger.dart';

extension $AdvertiserComplete on AdvertiserComplete {
  AdvertiserUpdate toAdvertiserUpdate() {
    return AdvertiserUpdate(
      name: name,
      groupManagerId: groupManagerId,
    );
  }
}
