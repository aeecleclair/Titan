import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/tools/functions.dart';

enum Status { waiting, open, closed, counting, published }

class StatusRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/status';

  StatusRepository(super.ref);

  Future<Status> getStatus() async {
    return stringToStatus((await getOne(''))['status']);
  }

  Future<bool> openVote() async {
    try {
      await create({}, suffix: "/open");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> closeVote() async {
    try {
      await create({}, suffix: '/close');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> countVote() async {
    try {
      await create({}, suffix: '/counting');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetVote() async {
    try {
      await create({}, suffix: '/reset');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> publishVote() async {
    try {
      await create({}, suffix: '/published');
      return true;
    } catch (e) {
      return false;
    }
  }
}

final statusRepositoryProvider = Provider((ref) {
  return StatusRepository(ref);
});
