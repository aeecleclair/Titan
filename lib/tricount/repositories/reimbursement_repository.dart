import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tricount/class/sharer_group.dart';

class ReimbursementRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tricount/reimburse";

  Future<List<SharerGroup>> reimburseTotal(String beneficiaryId) async {
    return List<SharerGroup>.from(
        (await getList(suffix: "reimburse/$beneficiaryId"))
            .map((x) => SharerGroup.fromJson(x)));
  }
}
