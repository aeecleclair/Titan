import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class MemeRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "meme/memes/";

  Future<List<Meme>> getMeme(SortingType sortingType) async {
    return (await getList(
      suffix: '?sort_by=${sortingType.name.split(".").last}',
    ))
        .map((e) => Meme.fromJson(e))
        .toList();
  }

  Future<Uint8List> getMemeImage(String id) async {
    final uint8List = await getLogo("", suffix: "$id/img");
    return uint8List;
  }

  Future<bool> deleteMeme(String id) async {
    return await delete(id);
  }

  Future<bool> addVoteToMeme(Meme meme, bool positive) async {
    try {
      await create(
        meme.toJson(),
        suffix: '${meme.id}/vote/?positive=$positive',
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateVoteToMeme(Meme meme, bool positive) async {
    return await update(
      meme.toJson(),
      meme.id,
      suffix: '/vote/?positive=$positive',
    );
  }

  Future<bool> deleteVoteToMeme(String id) async {
    return await delete(id, suffix: '/vote');
  }
}

final memeRepositoryProvider = Provider<MemeRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return MemeRepository()..setToken(token);
});
