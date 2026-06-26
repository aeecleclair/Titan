import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class PhPdfRepository {
  final Openapi client;
  PhPdfRepository(this.client);

  Future<Uint8List> getPhPdf(String id) async {
    final response = await client.phPaperIdPdfGet(paperId: id);
    return response.bodyBytes;
  }

  Future<Uint8List> updatePhPdf(Uint8List bytes, String id) async {
    await client.phPaperIdPdfPost(paperId: id, pdf: bytes);
    return bytes;
  }
}

final phPdfRepositoryProvider = Provider<PhPdfRepository>(
  (ref) => PhPdfRepository(ref.watch(repositoryProvider)),
);
