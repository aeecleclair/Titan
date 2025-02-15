import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class HiddenMemeRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "meme/memes/";

  Future<List<Meme>> getBannedMeme(int page) async {
    return (await getList(suffix: 'hidden?n_page=$page'))
        .map((e) => Meme.fromJson(e))
        .toList();
  }

  Future<bool> hideMeme(String id) async {
    return await create(
      "",
      suffix: '$id/hide',
    );
  }

  Future<bool> showMeme(String id) async {
    return await create(
      "",
      suffix: '$id/show',
    );
  }
}

final bannedMemeProvider = Provider<HiddenMemeRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return HiddenMemeRepository()..setToken(token);
});
