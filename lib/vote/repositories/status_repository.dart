import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/tools/functions.dart';

enum Status { waiting, open, closed, counting, published }

class StatusRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/status';

  Future<Status> getStatus() async {
    return stringToStatus((await getOne(''))['status'] as String);
  }

  Future<bool> openVote() async {
    try {
      await create(<String, dynamic>{}, suffix: "/open");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> closeVote() async {
    try {
      await create(<String, dynamic>{}, suffix: '/close');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> countVote() async {
    try {
      await create(<String, dynamic>{}, suffix: '/counting');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetVote() async {
    try {
      await create(<String, dynamic>{}, suffix: '/reset');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> publishVote() async {
    try {
      await create(<String, dynamic>{}, suffix: '/published');
      return true;
    } catch (e) {
      return false;
    }
  }
}

final statusRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return StatusRepository()..setToken(token);
});
