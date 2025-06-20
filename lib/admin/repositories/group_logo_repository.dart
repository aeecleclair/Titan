import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class GroupLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/';

  GroupLogoRepository(super.ref);
}

final groupLogoProvider = Provider((ref) {
  return GroupLogoRepository(ref);
});
