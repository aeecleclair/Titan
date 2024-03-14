import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/class/complete_member.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MemberPicturesNotifier extends MapNotifier<CompleteMember, Image> {
  MemberPicturesNotifier() : super();
}

final memberPicturesProvider = StateNotifierProvider<MemberPicturesNotifier,
    Map<CompleteMember, AsyncValue<List<Image>>?>>((ref) {
  MemberPicturesNotifier memberPicturesNotifier = MemberPicturesNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(associationMemberListProvider).maybeWhen(data: (member) {
      memberPicturesNotifier.loadTList(member);
      return MemberPicturesNotifier;
    }, orElse: () {
      memberPicturesNotifier.loadTList([]);
      return memberPicturesNotifier;
    });
  });
  return memberPicturesNotifier;
});
