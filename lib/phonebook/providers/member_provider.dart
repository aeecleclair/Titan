import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class MemberCompleteProvider extends StateNotifier<MemberComplete> {
  MemberCompleteProvider() : super(EmptyModels.empty<MemberComplete>());

  void setMemberComplete(MemberComplete i) {
    state = i;
  }
}

final memberProvider =
    StateNotifierProvider<MemberCompleteProvider, MemberComplete>((ref) {
  return MemberCompleteProvider();
});
