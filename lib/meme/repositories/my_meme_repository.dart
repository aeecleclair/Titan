import 'dart:async';
import 'dart:typed_data';
import 'package:myecl/tools/repository/logo_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/auth/providers/openid_provider.dart';

class MyMemeRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "meme/memes/";

  Future<List<Meme>> getMyMeme(int page) async {
    return (await getList(suffix: 'me')).map((e) => Meme.fromJson(e)).toList();
  }

  Future<bool> addMeme(Uint8List bytes) async {
    try {
      await addLogo(bytes, "", suffix: "");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMeme(String id) async {
    return await delete(id);
  }
}

final memeRepositoryProvider = Provider<MyMemeRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return MyMemeRepository()..setToken(token);
});
