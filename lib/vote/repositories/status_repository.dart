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

  Future<bool> updateStatus(Status status) async {
    return await update({'status': status.toString().split('.')[0]}, '');
  }
}
