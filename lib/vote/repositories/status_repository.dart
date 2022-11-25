import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/vote/tools/functions.dart';

enum Status { waiting, open, closed, counting }

class StatusRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/status';

  Future<Status> getStatus() async {
    return stringToStatus((await getOne(''))['status']);
  }

  Future<bool> openVote(Status status) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> closeVote(Status status) async {
    try {
      await create({}, suffix: '/close');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> countVote(Status status) async {
    try {
      await create({}, suffix: '/count');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetVote(Status status) async {
    try {
      await create({}, suffix: '/reset');
      return true;
    } catch (e) {
      return false;
    }
  }
}
