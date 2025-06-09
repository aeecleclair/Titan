import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/auth/providers/openid_provider.dart';
import 'package:myemapp/tools/repository/logo_repository.dart';

class GroupLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/';
}

final groupLogoProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return GroupLogoRepository()..setToken(token);
});
