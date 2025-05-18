import 'package:myecl/generated/openapi.models.swagger.dart';

extension $AdvertReturnComplete on AdvertReturnComplete {
  AdvertBase toAdvertBase() {
    return AdvertBase(
      title: title,
      content: content,
      advertiserId: advertiserId,
    );
  }

  AdvertUpdate toAdvertUpdate() {
    return AdvertUpdate(
      title: title,
      content: content,
      tags: tags,
    );
  }
}
