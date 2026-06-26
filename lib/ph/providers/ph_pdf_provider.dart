import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/repository/repository.dart';

class PhPdf extends AsyncNotifier<Uint8List> {
  PhPdf(this.phId);

  final String phId;

  Openapi get repository => ref.watch(repositoryProvider);

  @override
  Future<Uint8List> build() async {
    final response = await repository.phPaperIdPdfGet(paperId: phId);
    return response.bodyBytes;
  }

  Future<Uint8List> updatePhPdf(Uint8List bytes) async {
    await repository.phPaperIdPdfPost(paperId: phId, pdf: bytes);
    return bytes;
  }
}

final phPdfProvider = AsyncNotifierProvider.family<PhPdf, Uint8List, String>(
  PhPdf.new,
);
