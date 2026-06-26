import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';

class MemberPicturesNotifier extends MapNotifier<MemberComplete, Image> {
  @override
  Map<MemberComplete, AsyncValue<List<Image>>?> build() {
    ref
        .watch(associationMemberListProvider)
        .maybeWhen(
          data: (member) {
            loadTList(member);
          },
          orElse: () {},
        );
    return state;
  }
}

final memberPicturesProvider =
    NotifierProvider<
      MemberPicturesNotifier,
      Map<MemberComplete, AsyncValue<List<Image>>?>
    >(() => MemberPicturesNotifier());
