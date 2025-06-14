import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/vote/repositories/status_repository.dart';

class StatusNotifier extends SingleNotifier<Status> {
  final StatusRepository statusRepository;
  StatusNotifier({required this.statusRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<Status>> loadStatus() async {
    return await load(statusRepository.getStatus);
  }

  Future<bool> openVote() async {
    if (await statusRepository.openVote()) {
      state = const AsyncData(Status.open);
      return true;
    }
    return false;
  }

  Future<bool> closeVote() async {
    if (await statusRepository.closeVote()) {
      state = const AsyncData(Status.closed);
      return true;
    }
    return false;
  }

  Future<bool> countVote() async {
    if (await statusRepository.countVote()) {
      state = const AsyncData(Status.counting);
      return true;
    }
    return false;
  }

  Future<bool> resetVote() async {
    if (await statusRepository.resetVote()) {
      state = const AsyncData(Status.waiting);
      return true;
    }
    return false;
  }

  Future<bool> publishVote() async {
    if (await statusRepository.publishVote()) {
      state = const AsyncData(Status.published);
      return true;
    }
    return false;
  }
}

final statusProvider =
    StateNotifierProvider<StatusNotifier, AsyncValue<Status>>((ref) {
      final statusRepository = ref.watch(statusRepositoryProvider);
      final statusNotifier = StatusNotifier(statusRepository: statusRepository);
      tokenExpireWrapperAuth(ref, () async {
        await statusNotifier.loadStatus();
      });
      return statusNotifier;
    });
