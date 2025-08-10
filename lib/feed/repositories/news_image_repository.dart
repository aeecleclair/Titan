import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/logo_repository.dart';

class NewsImageRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'feed/news/';

  Future<Uint8List> getNewsImage(String id) async {
    return await getLogo(id, suffix: "/image");
  }
}

final newsImageRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return NewsImageRepository()..setToken(token);
});
