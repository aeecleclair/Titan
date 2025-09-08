import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/repositories/ph_cover_repository.dart';

final phCoverProvider = FutureProvider.family<Uint8List, String>((
  ref,
  id,
) async {
  final PhCoverRepository phPdfFirstPageRepository = ref.watch(
    phCoverRepositoryProvider,
  );
  return await phPdfFirstPageRepository.getPhPdfFirstPage(id);
});
