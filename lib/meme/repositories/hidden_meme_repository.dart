import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class HiddenMemeRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "meme/memes/";

  Future<List<Meme>> getHiddenMeme() async {
    return (await getList(suffix: 'hidden'))
        .map((e) => Meme.fromJson(e))
        .toList();
  }

  Future<Uint8List> getMemeImage(String id) async {
    final uint8List = await getLogo("", suffix: "$id/img");
    return uint8List;
  }

  Future<bool> hideMeme(String id) async {
    try {
      await create(
        "",
        suffix: '$id/hide',
      );
      return true;
    } catch (e) {
      return false;
    }
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
