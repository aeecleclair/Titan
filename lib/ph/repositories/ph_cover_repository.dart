import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/logo_repository.dart';

class PhCoverRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "ph/";

  Future<Uint8List> getPhPdfFirstPage(String id) async {
    final uint8List = await getLogo("", suffix: "$id/cover");
    return uint8List;
  }
}

final phCoverRepositoryProvider = Provider<PhCoverRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return PhCoverRepository()..setToken(token);
});
