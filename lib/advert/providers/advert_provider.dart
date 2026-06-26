import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class AdvertNotifier extends Notifier<AdvertComplete> {
  @override
  AdvertComplete build() {
    return AdvertComplete.empty();
  }

  void setAdvert(AdvertComplete i) {
    state = i;
  }
}

final advertProvider = NotifierProvider<AdvertNotifier, AdvertComplete>(
  AdvertNotifier.new,
);
