import 'package:myecl/tools/repository/repository.dart';

class StatusRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/status';

  Future<bool> getStatus() async {
    return (await getOne(''))['status'] ?? false;
  }

  Future<bool> updateStatus(bool status) async {
    return await update({'status': status}, '');
  }
}
