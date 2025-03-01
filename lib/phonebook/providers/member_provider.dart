import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class MemberCompleteProvider extends StateNotifier<MemberComplete> {
  MemberCompleteProvider() : super(MemberComplete.fromJson({}));

  void setMemberComplete(MemberComplete i) {
    state = i;
  }
}

final memberProvider =
    StateNotifierProvider<MemberCompleteProvider, MemberComplete>((ref) {
  return MemberCompleteProvider();
});
