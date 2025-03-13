import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class StatusNotifier extends SingleNotifierAPI<VoteStatus> {
  final Openapi statusRepository;
  StatusNotifier({required this.statusRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<VoteStatus>> loadStatus() async {
    return await load(statusRepository.campaignStatusGet);
  }

  Future<bool> openVote() async {
    if ((await statusRepository.campaignStatusOpenPost()).isSuccessful) {
      state = const AsyncData(VoteStatus(status: StatusType.open));
      return true;
    }
    return false;
  }

  Future<bool> closeVote() async {
    if ((await statusRepository.campaignStatusClosePost()).isSuccessful) {
      state = const AsyncData(VoteStatus(status: StatusType.closed));
      return true;
    }
    return false;
  }

  Future<bool> countVote() async {
    if ((await statusRepository.campaignStatusCountingPost()).isSuccessful) {
      state = const AsyncData(VoteStatus(status: StatusType.counting));
      return true;
    }
    return false;
  }

  Future<bool> resetVote() async {
    if ((await statusRepository.campaignStatusResetPost()).isSuccessful) {
      state = const AsyncData(VoteStatus(status: StatusType.waiting));
      return true;
    }
    return false;
  }

  Future<bool> publishVote() async {
    if ((await statusRepository.campaignStatusPublishedPost()).isSuccessful) {
      state = const AsyncData(VoteStatus(status: StatusType.published));
      return true;
    }
    return false;
  }
}

final statusProvider =
    StateNotifierProvider<StatusNotifier, AsyncValue<VoteStatus>>((ref) {
  final statusRepository = ref.watch(repositoryProvider);
  return StatusNotifier(statusRepository: statusRepository)..loadStatus();
});
