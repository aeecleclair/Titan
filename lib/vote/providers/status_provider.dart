import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/vote/repositories/status_repository.dart';

class StatusNotifier extends SingleNotifier<Status> {
  final statusRepository = StatusRepository();
  StatusNotifier({required String token}) : super(const AsyncValue.loading()) {
    statusRepository.setToken(token);
  }

  Future<AsyncValue<Status>> loadStatus() async {
    return await load(statusRepository.getStatus);
  }

  Future<bool> openVote() async {
    return await update(statusRepository.openVote, Status.open);
  }

  Future<bool> closeVote() async {
    return await update(statusRepository.closeVote, Status.closed);
  }

  Future<bool> countVote() async {
    return await update(statusRepository.countVote, Status.counting);
  }

  Future<bool> resetVote() async {
    return await update(statusRepository.resetVote, Status.waiting);
  }
}

final statusProvider =
    StateNotifierProvider<StatusNotifier, AsyncValue<Status>>((ref) {
  final token = ref.watch(tokenProvider);
  final statusNotifier =  StatusNotifier(token: token);
  statusNotifier.loadStatus();
  return statusNotifier;
});