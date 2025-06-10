import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/complete_member.dart';
import 'package:titan/phonebook/providers/association_member_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ProfilePictureNotifier extends MapNotifier<CompleteMember, Image> {
  ProfilePictureNotifier() : super();
}

final profilePicturesProvider =
    StateNotifierProvider<
      ProfilePictureNotifier,
      Map<CompleteMember, AsyncValue<List<Image>>?>
    >((ref) {
      ProfilePictureNotifier profilePictureNotifier = ProfilePictureNotifier();
      tokenExpireWrapperAuth(ref, () async {
        ref
            .watch(associationMemberListProvider)
            .maybeWhen(
              data: (profile) {
                profilePictureNotifier.loadTList(profile);
                for (final l in profile) {
                  profilePictureNotifier.setTData(l, const AsyncValue.data([]));
                }
                return profilePictureNotifier;
              },
              orElse: () {
                profilePictureNotifier.loadTList([]);
                return profilePictureNotifier;
              },
            );
      });
      return profilePictureNotifier;
    });
