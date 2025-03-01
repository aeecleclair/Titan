import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class PhNotifier extends StateNotifier<PaperComplete> {
  PhNotifier() : super(PaperComplete.fromJson({}));

  void setPh(PaperComplete ph) {
    state = ph;
  }
}

final phProvider = StateNotifierProvider<PhNotifier, PaperComplete>((ref) {
  return PhNotifier();
});
