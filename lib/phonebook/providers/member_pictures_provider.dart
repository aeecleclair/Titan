import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/phonebook/providers/association_member_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class MemberPicturesNotifier extends MapNotifier<MemberComplete, Image> {
  MemberPicturesNotifier() : super();
}

final memberPicturesProvider = StateNotifierProvider<MemberPicturesNotifier,
    Map<MemberComplete, AsyncValue<List<Image>>?>>((ref) {
  MemberPicturesNotifier memberPicturesNotifier = MemberPicturesNotifier();
  ref.watch(associationMemberListProvider).maybeWhen(
    data: (member) {
      memberPicturesNotifier.loadTList(member);
      return MemberPicturesNotifier;
    },
    orElse: () {
      memberPicturesNotifier.loadTList([]);
      return memberPicturesNotifier;
    },
  );
  return memberPicturesNotifier;
});
