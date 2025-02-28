import 'package:myecl/generated/openapi.swagger.dart';

extension $AdvertReturnComplete on AdvertReturnComplete {
  AdvertBase toAdvertBase() {
    return AdvertBase(
      title: title,
      content: content,
      advertiserId: advertiserId,
    );
  }
}
