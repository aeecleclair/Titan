import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class PhNotifier extends StateNotifier<PaperComplete> {
  PhNotifier() : super(EmptyModels.empty<PaperComplete>());

  void setPh(PaperComplete ph) {
    state = ph;
  }
}

final phProvider = StateNotifierProvider<PhNotifier, PaperComplete>((ref) {
  return PhNotifier();
});
