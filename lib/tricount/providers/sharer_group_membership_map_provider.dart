import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tricount/class/sharer_group.dart';
import 'package:myecl/tricount/class/sharer_group_membership.dart';
import 'package:myecl/tricount/providers/membership_provider.dart';

class SharerGroupMembershipMapNotifier
    extends MapNotifier<SharerGroupMembership, SharerGroup> {}

final sharerGroupMapProvider = StateNotifierProvider<
        SharerGroupMembershipMapNotifier,
        AsyncValue<Map<SharerGroupMembership, AsyncValue<List<SharerGroup>>>>>(
    (ref) {
  SharerGroupMembershipMapNotifier sharerGroupMembershipMapNotifier =
      SharerGroupMembershipMapNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(membershipListProvider).maybeWhen(data: (membershipList) {
      sharerGroupMembershipMapNotifier.loadTList(membershipList);
      for (final l in membershipList) {
        sharerGroupMembershipMapNotifier.setTData(l, const AsyncValue.data([]));
      }
      return sharerGroupMembershipMapNotifier;
    }, orElse: () {
      sharerGroupMembershipMapNotifier.loadTList([]);
      return sharerGroupMembershipMapNotifier;
    });
  });
  return sharerGroupMembershipMapNotifier;
});
