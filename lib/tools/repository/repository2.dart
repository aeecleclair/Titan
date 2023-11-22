import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/authenticator/authenticator.dart';
import 'package:myecl/tools/repository/constants.dart';

final repositoryProvider = Provider((ref) {
  final authenticator = ref.watch(authenticatorProvider);
  return Openapi.create(
      baseUrl: Uri.parse(BASE_URL), authenticator: authenticator);
});
