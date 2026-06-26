import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/repository/repository.dart';

final phCoverProvider = FutureProvider.family<Uint8List, String>((
  ref,
  id,
) async {
  final response = await ref
      .watch(repositoryProvider)
      .phPaperIdCoverGet(paperId: id);
  return response.bodyBytes;
});
