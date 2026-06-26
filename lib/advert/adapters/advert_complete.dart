import 'package:titan/generated/openapi.models.swagger.dart';

extension $AdvertComplete on AdvertComplete {
  AdvertBase toAdvertBase() {
    return AdvertBase(
      title: title,
      content: content,
      advertiserId: advertiserId,
      notification: notification,
    );
  }

  AdvertUpdate toAdvertUpdate() {
    return AdvertUpdate(title: title, content: content);
  }
}
