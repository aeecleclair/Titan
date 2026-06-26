import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class PhNotifier extends Notifier<PaperComplete> {
  @override
  PaperComplete build() {
    return PaperComplete.empty();
  }

  void setPh(PaperComplete ph) {
    state = ph;
  }
}

final phProvider = NotifierProvider<PhNotifier, PaperComplete>(PhNotifier.new);
